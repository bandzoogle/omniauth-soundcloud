# frozen_string_literal: true

require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class SoundCloud < OmniAuth::Strategies::OAuth2
      option :name, 'soundcloud'

      option :client_options, {
        site: 'https://secure.soundcloud.com',
        authorize_url: 'https://secure.soundcloud.com/authorize',
        token_url: 'https://secure.soundcloud.com/oauth/token'
      }

      option :token_params, {
        'headers' =>
          {
            'Accept' => 'application/json; charset=utf-8'
          }
      }

      uid { raw_info.client.id }

      info do
        {}
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token
      end

      def request_phase
        redirect client.auth_code.authorize_url(authorize_params)
      end

      def callback_url
        options['client_options']['redirect_uri']
      end
    end
  end
end

OmniAuth.config.add_camelization 'soundcloud', 'SoundCloud'
