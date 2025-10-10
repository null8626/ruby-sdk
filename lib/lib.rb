# frozen_string_literal: true

require "base64"
require "json"

require_relative "topgg/bot"
require_relative "topgg/botSearch"
require_relative "topgg/stats"
require_relative "topgg/user"
require_relative "topgg/vote"
require_relative "topgg/votes"
require_relative "topgg/webhooks"
require_relative "topgg/widget"
require_relative "topgg/utils/request"

# Class Topgg
# Top.gg API v0 client
class Topgg
  # Initializes the client
  # @param token [String] Your Top.gg API token
  def initialize(token)
    begin
      token_section = token.split('.')[1]
      padding = '=' * ((4 - token_section.length % 4) % 4)
      token_section += padding
  
      token_data = JSON.parse(Base64.decode64(token_section))
          
      @id = token_data['id']
    rescue StandardError
      raise ArgumentError, 'Got a malformed API token.'
    end

    @token = token
    @request = Dbl::Utils::Request.new(token)
  end

  # Get Discord bot statistics from top.gg
  # @param id [String] The bot's ID
  # @return [Dbl::Bot] The Bot Object
  def get_bot(id)
    Dbl::Bot.new(@request.get("bots/#{id}"))
  end

  # Searches Discord bots from Top.gg using a keyword query.
  # @param [Object] params The parameters that can be used to query a search
  # To know what the parameters are check it out here
  # @return [Dbl::BotSearch] The BotSearch Object
  def search_bot(params)
    Dbl::BotSearch.new(@request.get("bots", params))
  end

  # [Deprecated] Fetch a user on Top.gg based on an ID
  # @param id [String] The user's ID
  # @return [Dbl::User]
  def user(id)
    nil
  end

  # Get your Discord bot's posted statistics
  # @param id [String] The bot's ID. Unused, no longer has an effect.
  # @return [Dbl::Stats]
  def get_stats(id = nil)
    Dbl::Stats.new(@request.get("bots/stats"))
  end

  # Mini-method to query if your project was voted by the user in the past 12 hours.
  # @param userid [String] The user's ID.
  # @return [Boolean]
  def voted?(userid)
    resp = @request.get("bots/check", { userId: userid })
    resp["voted"] == 1
  end

  # Checks if the weekend multiplier is active, where a single vote counts as two.
  # @return [Boolean]
  def is_weekend?
    resp = @request.get("weekend")
    resp["is_weekend"]
  end

  # Get the unique votes of your project
  # @param page [Integer] The page to use. Defaults to 1.
  # @return [Dbl::Votes]
  def votes(page = 1)
    page = page.to_i
    page = 1 if page < 1

    Dbl::Votes.new(@request.get("bots/#{@id}/votes", { page: page }))
  end

  # Posts your Discord bot's statistics to the API. This will update the statistics in your Discord bot's Top.gg page.
  # @param server_count [Integer] The amount of servers the bot is in. Must not be less than 1.
  # @param shards [Integer] The amount of servers the bot is in per shard. Unused, no longer has an effect.
  # @param shard_count [Integer] The total number of shards. Unused, no longer has an effect.
  def post_stats(server_count, shards = nil, shard_count = nil)
    raise ArgumentError, "server_count cannot be less than 1" unless server_count > 0

    json_post = { server_count: server_count }.to_json
    @request.post(
      "bots/stats",
      json_post
    )
  end

  # Auto-posts your Discord bot's stats to the Top.gg website
  # @param client [Discordrb::Bot] instanceof discordrb client.
  def auto_post_stats(client)
    semaphore = Mutex.new
    Thread.new do
      semaphore.synchronize do
        interval 900 do
          server_len = client.servers.length
          post_stats(server_len)
          puts(
            "[TOPGG] : \033[31;1;4m Bot statistics has been successfully posted!\033[0m"
          )
        end
      end
    end
  end

  # Mini-method to get statistics on self
  # @return [get_bot]
  def self
    get_bot(@id)
  end

  def interval(seconds)
    loop do
      yield
      sleep seconds
    end
  end
end

# Top.gg API v1 client
class V1Topgg < Topgg
  # Updates the application commands list in your Discord bot's Top.gg page.
  # @param commands [String] A list of application commands in raw Discord API JSON objects. This cannot be empty.
  def post_commands(commands)
    @request.post("v1/projects/@me/commands", commands)
  end
  
  # Get the latest vote information of a Top.gg user on your project.
  # @param id [String] The user's ID.
  # @param source [String] The ID type to use. Defaults to "discord".
  # @return [Dbl::Vote]
  def vote(id, source = "discord")
    raise ArgumentError, "source must be either \"discord\" or \"topgg\"" unless source == "discord" or source == "topgg"

    begin
      Dbl::Vote.new(@request.get("v1/projects/@me/votes/#{id}", { source: source }))
    rescue Net::HTTPError => err
      return nil if err.response.code == "404"
      raise
    end
  end
end