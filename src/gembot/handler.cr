module Gembot
  alias EventData = Discord::Message

  class Handler
    alias HandlerCallback = Proc(RClient, EventData, Nil)
    getter etype
    getter callback
    getter allow_pm

    @allow_pm = false

    def initialize(@etype : Symbol, @condition : Regex?, @callback : HandlerCallback)
    end

    def initialize(@etype : Symbol, @callback : HandlerCallback)
    end

    def triggered?(edat : EventData)
      case edat
      when Discord::Message
        return !(edat.content =~ @condition).nil?
      end
    end
  end

  class RClient
    def initialize(@client : Discord::Client, @cache : Discord::Cache)
    end

    def reply(to : Discord::Message, text)
      @client.create_message(to.channel_id, text)
    end

    def reply!(to : Discord::Message, text)
      @client.create_message(to.channel_id, mention(to.author) + ": " + text)
    end

    def mention(user : Discord::User)
      "<@#{user.id}>"
    end
  end
end
