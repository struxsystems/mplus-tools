# frozen_string_literal:true

# !/usr/bin/env ruby

# Set Rails Environment
RAILS_ENV = 'production'

$LOAD_PATH << '.'

# Require Rails Files for Inclusion
require 'config/boot.rb'
require 'config/application.rb'

# Load Rails into PORO/Static Ruby
Rails.application.require_environment!

# Initialize Bot
bot = Discordrb::Bot.new token: 'NDg4MzE5MTkwMzkwOTMxNDY3.DnaeZA.JSrKgt1Himdj8jYfBpNlq_8Wq14', client_id: '488319190390931467'

# Respond to a!user command. Testing Function.
bot.message(containing: '!mplus -identify') do |event|
  user = User.find_by(discord_id: "#{event.message.author.username}##{event.message.author.discriminator}")

  if user.present?
    # Send an embedded response.
    bot.channel(event.channel.id).send_embed do |e|
      e.thumbnail = { url: "https://render-us.worldofwarcraft.com/character/#{user.characters.default.first.thumbnail}",
                      height: 60,
                      width: 60 }
      e.add_field name: 'Battle Tag:', value: user.battle_tag, inline: true
      e.color = 0xE82C0C
    end
  else
    event.respond 'You are not registered.'
  end
end

# Run the script, Open Websocket and Listen.
bot.run