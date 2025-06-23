# frozen_string_literal: true

require "base64"
require "json"

require_relative "topgg/utils/request"
require_relative "topgg/bot"
require_relative "topgg/botSearch"
require_relative "topgg/user"
require_relative "topgg/stats"
require_relative "topgg/votes"
require_relative "topgg/widget"

# Class Topgg
# The class instantiates all the methods for api requests and posts.
class Topgg
  # initializes the class attributes.
  # @param token [String] The authorization token from top.gg
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

  # The method fetches bot statistics from top.gg
  # @param id [String] The id of the bot you want to fetch statistics from.
  # @return [Dbl::Bot] The Bot Object
  def get_bot(id)
    Dbl::Bot.new(@request.get("bots/#{id}"))
  end

  # The method searches bots from top.gg using a keyword query.
  # @param [Object] params The parameters that can be used to query a search
  # To know what the parameters are check it out here
  # @return [Dbl::BotSearch] The BotSearch Object
  def get_bots(params)
    Dbl::BotSearch.new(@request.get("bots", params))
  end

  # Get Bot statistics.
  # @return [Dbl::Stats]
  def get_stats
    Dbl::Stats.new(@request.get("bots/stats"))
  end

  # Mini-method to query if the bot(self) was voted by the user.
  # @param userid [String] The user id.
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

  # Get the last 1000 unique votes of the bot(self)
  # @param page [Integer] The page to use. Defaults to 1.
  # @return [Dbl::Votes]
  def get_votes(page = 1)
    page = 1 if page.to_i < 1
    resp = @request.get("bots/#{@id}/votes", { page: page })

    Dbl::Votes.new(resp)
  end

  # Post Bot Statistics to the website
  # @param server_count [Integer] The amount of servers the bot is in. Must not be less than 1.
  def post_stats(server_count)
    raise ArgumentError, "server_count cannot be less than 1" unless server_count > 0

    json_post = { server_count: server_count }.to_json
    @request.post(
      "bots/stats",
      json_post
    )
  end

  # Auto-posts stats on to the top.gg website
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
