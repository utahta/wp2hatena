require 'sinatra/base'
require 'oauth'
require 'erb'
require 'json'

module Wp2hatena
  module Hatena
    module OAuth

      class App < Sinatra::Base
        set :sessions, true
        enable :sessions

        before do
          @consumer = ::OAuth::Consumer.new(
              CONSUMER_KEY,
              CONSUMER_SECRET,
              :site => '',
              :request_token_path => 'https://www.hatena.com/oauth/initiate',
              :access_token_path => 'https://www.hatena.com/oauth/token',
              :authorize_path => 'https://www.hatena.ne.jp/oauth/authorize'
          )
        end

        get '/' do
          erb :index
        end

        # リクエストトークン取得から認証用URLにリダイレクトするためのアクション
        get '/oauth' do
          # リクエストトークンの取得
          request_token = @consumer.get_request_token(
              {:oauth_callback => 'http://localhost:4567/oauth_callback'},
              :scope => 'read_public,write_public,read_private,write_private'
          )

          # セッションへリクエストトークンを保存しておく
          session[:request_token] = request_token.token
          session[:request_token_secret] = request_token.secret

          # 認証用URLにリダイレクトする
          redirect request_token.authorize_url
        end

        # 認証からコールバックされ、アクセストークンを取得するためのアクション
        get '/oauth_callback' do
          request_token = ::OAuth::RequestToken.new(
              @consumer,
              session[:request_token],
              session[:request_token_secret]
          )

          # リクエストトークンとverifierを用いてアクセストークンを取得
          access_token = request_token.get_access_token(
              {},
              :oauth_verifier => params[:oauth_verifier]
          )

          session[:request_token] = nil
          session[:request_token_secret] = nil

          # アクセストークンをセッションに記録しておく
          session[:access_token] = access_token.token
          session[:access_token_secret] = access_token.secret

          erb :oauth_callback, :locals => {:access_token => access_token}
        end
      end

    end
  end
end
