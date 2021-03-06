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
            tag = make_tag(data)
            buffer.gsub!(data[:html_tag], "[#{data[:syntax]}#{tag}]\r\n")
            puts "converted [#{data[:syntax]}#{tag}]"
          end

          buffer.gsub!("\r\n", "  \n") # 改行してくれないので、スペース2つ入れて対応
          File.write(dest_path, buffer)
        end
      end

      private

      def make_tag(data)
        tag = ''
        if data[:width] and data[:height]
          tag = ":w#{data[:width]},h#{data[:height]}"
        elsif data[:width]
          tag = ":w#{data[:width]}"
        elsif data[:height]
          tag = ":h#{data[:height]}"
        end
        tag
      end
    end

  end
end
