module Gembot
  class Plugin
    @@commands = {} of String => Hash(Symbol, String)
    @@handlers = [] of Gembot::Handler

    macro description(value)
      @@description = {{value}}
    end

    macro command(cmd, opt)
      @@commands[{{cmd}}] = {{opt}}
    end

    def self.on_message(matching : Regex, &block : Gembot::RClient, Gembot::EventData -> Nil)
      @@handlers << Gembot::Handler.new(:message, matching, block)
    end

    def hook(client)
      @@handlers.each { |handler| handler.hook(client) }
    end
  end
end
