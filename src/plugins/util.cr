require "../gembot"

module Gembot
  module Plugins
    class Utilities < Gembot::Plugin
      description "various useful utilities"

      command "ping", {:description => "replies with pong"}
      on_message /^\~ping/ do |c, m|
        c.reply(m, "pong~~~~")
      end

      command "hcf", {:description => "kills the bot"}
      on_message /^\~hcf/ do |c, m|
      end

      command "help", {:description => "returns help"}
      on_message /^\~help/ do |c, m|
      end
    end
  end
end
