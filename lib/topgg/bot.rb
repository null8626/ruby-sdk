require "date"

module Dbl
  # A Discord bot listed on Top.gg
  class Bot
    # Initializes the Bot class
    # @param obj [Object]
    def initialize(obj)
      @obj = obj
    end

    # The raw hash of the parsed JSON object
    # @return [Hash]
    attr_reader :obj

    alias raw obj
    alias data obj

    # The error message if there's an error, otherwise nil
    # @return [String]
    def error
      @obj["error"]
    end

    # The bot's default avatar
    # @return [String]
    def defAvatar
      ""
    end

    # The bot's invite URL
    # @return [String]
    def invite
      @obj["invite"]
    end

    # The bot's website URL, if configured
    # @return [String]
    def website
      @obj["website"]
    end

    # The bot's support server URL
    # @return [String]
    def support
      @obj["support"]
    end

    # The bot's github repository URL, if any
    # @return [String]
    def github
      @obj["github"]
    end

    # The bot's long description
    # @return [String]
    def longdesc
      @obj["longdesc"]
    end

    # The bot's short description
    # @return [String]
    def shortdesc
      @obj["shortdesc"]
    end

    # The bot's default prefix
    # @return [String]
    def prefix
      @obj["prefix"]
    end

    # The bot's client ID
    # @return [String]
    def clientid
      @obj["clientid"]
    end

    # The bot's avatar URL
    # @return [String]
    def avatar
      @obj["avatar"]
    end

    # The bot's ID
    # @return [String]
    def id
      @obj["id"]
    end

    # The bot's discriminator
    # @return [String]
    def discriminator
      "0"
    end

    # The bot's username
    # @return [String]
    def username
      @obj["username"]
    end

    # The bot's submission date
    # @return [Date]
    def date
      Date.parse(@obj["date"])
    end

    # The bot's posted server count
    # @return [Integer]
    def server_count
      @obj["server_count"].to_i
    end

    # The bot's posted shard count
    # @return [Integer]
    def shard_count
      0
    end

    # The configured servers in which the bot is in
    # @return [Array<String>]
    def guilds
      nil
    end

    # The server count for each shard of the bot
    # @return [Array<Integer>]
    def shards
      nil
    end

    # The bot's monthly votes
    # @return [Integer]
    def monthlyPoints
      @obj["monthlyPoints"].to_i
    end

    # The bot's total votes
    # @return [Integer]
    def points
      @obj["points"].to_i
    end

    # The bot's vanity code, can be nil
    # @return [String]
    def vanity
      @obj["vanity"]
    end

    # The bot's owner IDs
    # @return [Array<String>]
    def owners
      @obj["owners"]
    end

    # The bot's tags
    # @return [Array<String>]
    def tags
      @obj["tags"]
    end

    # The bot's reviews
    # @return [Object]
    def reviews
      @obj["reviews"]
    end
  end
end
