# frozen_string_literal:true

# !/usr/bin/env ruby

# Set Rails Environment
RAILS_ENV = 'production'

$LOAD_PATH << '.'

# Require Rails Files for Inclusion
require 'config/boot.rb'
require 'config/application.rb'
require 'discordrb'
require 'securerandom'

# Load Rails into PORO/Static Ruby
Rails.application.require_environment!

# Initialize Bot
bot = Discordrb::Commands::CommandBot.new token: 'NDg4MzE5MTkwMzkwOTMxNDY3.DnaeZA.JSrKgt1Himdj8jYfBpNlq_8Wq14', client_id: '488319190390931467', prefix: '!mplus -'

# Identifies a user, returns registration status to chat channel.
bot.command(:identify) do |event, *args|
  user = User.find_by(discord_id: "#{event.user.username}##{event.user.discriminator}")

  if user
    "Registered As: #{user.battletag}"
  else
    'Not Registered'
  end
end

# Registers a user, Returns battle tag and access code to PM
bot.command(:register) do |event, battletag|

  user = User.find_by(discord_id: "#{event.user.username}##{event.user.discriminator}")

  if user
    "Already Registered."
  else
    access_code = SecureRandom.hex(8)
  
    user = User.create( battletag: battletag,
      email: "#{battletag}@mplus.gg",
      password: SecureRandom.hex(16),
      verified: false,
      discord_id: "#{event.user.username}##{event.user.discriminator}",
      access_code: access_code)

      event.user.pm("Registered your user for Battletag #{battletag}. ```Your Secure Access Token is: #{access_code}``` Use this code for any account related updates. **Do Not Use In Public Channels**")
  end
end

# Adds a character to a user. Returns character info in chat.
bot.command(:addchar) do |event, *args|
  user = User.find_by(discord_id: "#{event.user.username}##{event.user.discriminator}")

  if user
    char_array = args[0].split('/')
    access_code = args[1]

    ap char_array

    get_from_raider_io(char_array)

    character_search = Character.where(name: @json_response["name"]).where(realm: @json_response["realm"])&.first

    if character_search
      "Character Already Claimed. If this is in error, ask for help from the admins."
    else
      character = Character.create( user_id: user.id,
                                    raider_io_pull: Time.now,
                                    name: @json_response["name"],
                                    realm: @json_response["realm"],
                                    region: @json_response["region"],
                                    guild: @json_response["guild"]["name"],
                                    raider_io_score: @json_response["mythic_plus_scores"]["all"],
                                    item_level: @json_response["gear"]["item_level_equipped"],
                                    thumbnail_url: @json_response["thumbnail_url"],
                                    verified: access_code&.present? ? true : false)

      event.channel.send_embed do |embed|
        embed.colour = 0x7ed321
        embed.timestamp = Time.now
      
        embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{character.thumbnail_url}")
      
        embed.add_field(name: "Character", value: "#{character.name}", inline: true)
        embed.add_field(name: "Guild", value: "#{character.guild}", inline: true)
        embed.add_field(name: "Realm", value: "#{character.realm}", inline: true)
        embed.add_field(name: "Region", value: "#{character.region.upcase}", inline: true)
        embed.add_field(name: "Raider.io Score", value: "**#{character.raider_io_score}**", inline: true)
        embed.add_field(name: "Item Level (equipped)", value: "#{character.item_level}", inline: true)
        
      end
    end
  else
    "Please register your battletag first."
  end
end

bot.command(:getscore) do |event, char_string|

  char_array = char_string.split('/')

  get_from_raider_io(char_array)

  event.channel.send_embed do |embed|
    embed.colour = 0x7ed321
    embed.timestamp = Time.now
  
    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{@json_response["thumbnail_url"]}")
  
    embed.add_field(name: "Character", value: "#{@json_response["name"]}", inline: true)
    embed.add_field(name: "Raider.io Score", value: "**#{@json_response["mythic_plus_scores"]["all"]}**", inline: true)
    embed.add_field(name: "Guild", value: "#{@json_response["guild"]["name"]}", inline: true)
    embed.add_field(name: "Realm", value: "#{@json_response["realm"]}", inline: true)
  end
end

def get_from_raider_io(char_array)
  response = Excon.get("https://raider.io/api/v1/characters/profile?region=#{char_array[0]}&realm=#{char_array[1]}&name=#{char_array[2]}&fields=gear%2Cguild%2Cmythic_plus_scores")

  @json_response = JSON.parse(response.body)

  ap @json_response

  return @json_response
end

bot.run