require "../gembot"

module Gembot
  module Plugins
    class Giveme < Gembot::Plugin
      description ":gay_pride_flag: Colored names and role givemes"

      register_commands do
        command "color <color name>", description: "give a user a colored role. create it if it does not exist."
        on_message cmatching: "color" do |c, m|
          color = m.content.split(' ')[1]
          if color.starts_with? '#'
            value = color[1..-1].to_u32?(base: 16)
            if value.nil?
              c.reply!(m, "Hex value malformed or out of range [0x000000...0xffffff]")
              next
            end

            hex = color[1..-1].to_u32(base: 16)
          else
            unless COLOR_TABLE.has_key? color
              c.reply!(m, "No such color `#{color}`")
              next
            end
            hex = COLOR_TABLE[color]
          end

          color_role_name = m.author.username
          guild = c.guild_of(m)
          role = c.fetch_or_create_role(guild, name: color_role_name)
          @bot.client.modify_guild_role(guild_id: guild.id, role_id: role.id, name: color_role_name, colour: hex,
            permissions: role.permissions, position: nil, hoist: nil)
          unless c.get_member(guild, m.author).roles.includes? role.id
            c.role_add_user(guild, role, m.author)
          end

          unless color.starts_with? '#'
            c.reply!(m, "Setting your color to #{color}/`#%x`" % hex)
          else
            c.reply!(m, "Setting your color to #{color}")
          end
        end
      end

      COLOR_TABLE = {
        # from http://clrs.cc
        "navy" => 0x001f3f_u32,
        "blue" => 0x0074d9_u32,
        "aqua" => 0x7fdbff_u32,
        "teal" => 0x39cccc_u32,
        "olive" => 0x3d9970_u32,
        "green" => 0x2ecc40_u32,
        "lime" => 0x01ff70_u32,
        "yellow" => 0xffdc00_u32,
        "orange" => 0xff851b_u32,
        "red" => 0xff4136_u32,
        "maroon" => 0x85144b_u32,
        "fuchsia" => 0xf012be_u32,
        "purple" => 0xb10dc9_u32,
        "black" => 0x111111_u32,
        "gray" => 0xaaaaaa_u32,
        "silver" => 0xdddddd_u32,
        "white" => 0xffffff_u32,

        # suggested by members of `array.pop()`
        "lavender" => 0xc5aef5_u32,
      }
    end
  end
end
