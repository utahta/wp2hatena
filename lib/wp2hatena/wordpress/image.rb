require 'open-uri'
require 'tmpdir'

module Wp2hatena
  module Wordpress
    class Image
      def initialize
        @tmp_dir = Dir.mktmpdir
      end

      def download(xml_path)
        open(xml_path, 'r') do |fp|
          fp.each_line do |line|
            line.match(/<a.*?href="([^"]+?)"><img.*?src="(.+?)".*?><\/a>/) do |md|
              image_url = nil
              image_url = md[2] if md[2].match(/.+\.(jpg|jpeg|gif|png|bmp)\Z/)
              image_url = md[1] if md[1].match(/.+\.(jpg|jpeg|gif|png|bmp)\Z/)
              data = {
                  file_path: fetch_image(image_url),
                  width: match_width(line),
                  height: match_height(line),
              }
              yield data
            end
          end
        end
      end

      private

      def fetch_image(url)
        file_path = File.join(@tmp_dir, File.basename(url))
        open(file_path, 'wb') do |fp|
          open(url) do |data|
            fp.write(data.read)
          end
        end
        file_path
      end

      def match_width(str)
        width = nil
        str.match(/width="([^"]+)"/) do |md|
          width = md[1]
        end
        width
      end

      def match_height(str)
        height = nil
        str.match(/height="([^"]+)"/) do |md|
          height = md[1]
        end
        height
      end
    end
  end
end
