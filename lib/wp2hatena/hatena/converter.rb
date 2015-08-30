module Wp2hatena
  module Hatena

    class Converter
      def initialize
        @convert_data = []
      end

      def set_convert_data(html_tag, width, height, syntax)
        @convert_data << {
            html_tag: html_tag,
            width: width,
            height: height,
            syntax: syntax
        }
      end

      def convert(src_path, dest_path)
        open(src_path, 'r') do |fp|
          buffer = fp.read
          @convert_data.each do |data|
            tag = ''
            if data[:width] and data[:height]
              tag = ":w#{data[:width]},h#{data[:height]}"
            elsif data[:width]
              tag = ":w#{data[:width]}"
            elsif data[:height]
              tag = ":h#{data[:height]}"
            end

            buffer.gsub!(data[:html_tag], "[#{data[:syntax]}#{tag}]\r\n")
            puts "converted [#{data[:syntax]}#{tag}]"
          end

          buffer.gsub!("\r\n", "  \n")
          File.write(dest_path, buffer)
        end
      end
    end

  end
end
