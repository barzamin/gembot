require "discordcr"

module Gembot
  class Bot
    def initialize(config : Config)
      @config = config
      @client = Discord::Client.new(token: @config.token, client_id: @config.client_id)
      @cache = Discord::Cache.new(@client)
      @client.cache = @cache
    end

    # Kick off the main Discord event loop
    def run!
      @client.run
    end
  end
end
