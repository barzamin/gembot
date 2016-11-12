require "discordcr"

module Gembot
  class Bot
    property plugins

    def initialize(config : Config)
      @config = config

      @client = Discord::Client.new(token: @config.token, client_id: @config.client_id)
      @cache = Discord::Cache.new(@client)
      @client.cache = @cache

      @plugins = [] of Gembot::Plugin
    end

    def load_plugins!
      @plugins.each { |p| p.hook(@client) }
    end

    # Kick off the main Discord event loop
    def run!
      @client.run
    end
  end
end
