require "yaml"

module Gembot
  class Config
    # The Discord API token
    property token

    # Map in properties from config.yml
    YAML.mapping(
      prefix: String,
    )
  end
end
