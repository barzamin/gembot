module Gembot
  class Handler
    alias HandlerCallback = Proc(RClient, EventData, Nil)

    def initialize(@etype : Symbol, @condition : Regex?, @block : HandlerCallback)
    end

    def initialize(@etype : Symbol, @block : HandlerCallback)
    end

    def hook(client)
    end
  end
end
