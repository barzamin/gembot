require "./gembot"
require "./plugins/util"
require "dotenv"

Dotenv.load
config = Gembot::Config.from_yaml(File.read("./config.yml"))
config.token = ENV["TOKEN"]
config.client_id = ENV["CLIENT_ID"].to_u64

bot = Gembot::Bot.new(config)
bot.plugins << Gembot::Plugins::Utilities.new
bot.load_plugins!
bot.run!
