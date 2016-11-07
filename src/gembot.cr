require "dotenv"
require "./gembot/*"

Dotenv.load
config = Gembot::Config.from_yaml(File.read("./config.yml"))
config.token = ENV["TOKEN"]

bot = Gembot::Bot.new(config)
bot.run
