require 'rexml/document'
require 'oauth'

module Wp2hatena
  module Hatena

    class Fotolife
      def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
        @consumer = OAuth::Consumer.new(
            consumer_key,
            consumer_secret,
            :site => 'http://f.hatena.ne.jp',
        )
        @access_token = OAuth::AccessToken.new(
            @consumer,
            access_token,
            access_token_secret
        )
      end

      def upload(file_path, title, folder_name = 'Hatena Blog')
        header = {'Accept' => 'application/xml', 'Content-Type' => 'application/xml'}
        content = Base64.encode64(open(file_path).read)
        dc_subject = folder_name ? "<dc:subject>#{folder_name}</dc:subject>" : ''
        body =<<-"EOF"
<entry xmlns=http://purl.org/atom/ns>
  <title>#{title}</title>
  #{dc_subject}
  <content mode='base64' type='image/jpeg'>#{content}</content>
</entry>
EOF
        response = @access_token.request(:post, '/atom/post', body, header)
        doc = REXML::Document.new(response.body)
        {
            id: doc.elements['entry/id'].text,
            imageurl: doc.elements['entry/hatena:imageurl'].text.gsub(/\?.*/, ''),
            imageurlsmall: doc.elements['entry/hatena:imageurlsmall'].text.gsub(/\?.*/, ''),
            syntax: doc.elements['entry/hatena:syntax'].text
        }
      end
    end
  end
end
