require "discordcr"

module Gembot
  class Bot
    property config
    property plugins

    property client

    def initialize(@config : Config)
      @client = Discord::Client.new(token: @config.token, client_id: @config.client_id)
      @cache = Discord::Cache.new(@client)
      @client.cache = @cache

      @rclient = RClient.new(@client)

      @plugins = [] of Plugin
      @handlers = {} of Symbol => Array(Handler)
    end

    def load_plugins!
      @plugins.each(&.regis)
      @handlers = @plugins.map(&.handlers)
                          .flatten
                          .group_by(&.etype)

      helptext = Help.generate_from(@config, @plugins)

      @handlers.each do |etype, hs|
        case etype
        when :message
          @client.on_message_create do |payload|
            # skip own messages
            if payload.author == @cache.resolve_current_user
              next
            end

            # special case of ~help, it's not currently a plugin
            if payload.content == @config.prefix + "help"
              @rclient.reply(payload, helptext)
            end

            hs.each do |h|
              if h.triggered? payload
                h.callback.call @rclient, payload
              end
            end
          end
        end
      end
    end

    # Kick off the main Discord event loop
    def run!
      @client.run
    end
  end
end
