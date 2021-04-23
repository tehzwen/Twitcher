# frozen_string_literal: true

require_relative "twitcher/version"
require 'httparty'

module Twitcher
  class Error < StandardError; end
  
  class Client

    attr_accessor :token, :client_id, :token_expires_in
    attr :client_secret, :time_authed

    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
    end

    def secrets
      {
        id: @client_id,
        secret: @client_secret
      }
    end

    def authorized?
      return @token != nil && Time.new - time_authed < @token_expires_in
    end

    def authenticate
      query = {
          client_id: @client_id,
          client_secret: @client_secret,
          grant_type: "client_credentials" 
      }
      res = HTTParty.post("https://id.twitch.tv/oauth2/token", query: query)
      time_authed = Time.new
      @token_expires_in = res["expires_in"]
      @token = res["access_token"]
    end

    def query_url(url:)
      HTTParty.get(url)
    end

    def get_channel(channel_name:)
      query = {
        query: channel_name
      }
      headers = {
        "client-id": @client_id,
        Authorization: "Bearer #{@token}"
      }

      HTTParty.get("https://api.twitch.tv/helix/search/channels", query: query, headers: headers)['data']
    end
  end

end
