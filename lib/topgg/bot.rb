require "date"

module Dbl
  # The Bot class spreads the json parsed hash into different methods
  class Bot
    # Initializes the Bot class
    # @param obj [Object]
    def initialize(obj)
      @obj = obj
    end

    # Returns raw hash of the parsed json object
    # @return [Hash]
    attr_reader :obj

    alias raw obj
    alias data obj

    # Returns error message if there's an error, otherwise nil
    # @return [String]
    def error
      @obj["error"]
    end

    # Returns the invite link of the bot
    # @return [String]
    def invite
      @obj["invite"]
    end

    # Returns the bot website, if configured
    # @return [String]
    def website
      @obj["website"]
    end

    # Returns support server link
    # @return [String]
    def support
      @obj["support"]
    end

    # Returns github repository link, if any
    # @return [String]
    def github
      @obj["github"]
    end

    # Returns the long Description of the bot
    # @return [String]
    def longdesc
      @obj["longdesc"]
    end

    # Returns the short description of the bot
    # @return [String]
    def shortdesc
      @obj["shortdesc"]
    end

    # Returns the default prefix of the bot
    # @return [String]
    def prefix
      @obj["prefix"]
    end

    # Returns the bot client id
    # @return [String]
    def clientid
      @obj["clientid"]
    end

    # Returns the avatar link of the bot
    # @return [String]
    def avatar
      @obj["avatar"]
    end

    # Returns the bot id
    # @return [String]
    def id
      @obj["id"]
    end

    # Returns the bot username
    # @return [String]
    def username
      @obj["username"]
    end

    # Returns the date on which the bot was submitted
    # @return [Date]
    def date
      Date.parse(@obj["date"])
    end

    # Returns the server count of the bot
    # @return [Integer]
    def server_count
      @obj["server_count"].to_i
    end

    # Returns the monthly vote count of the bot
    # @return [Integer]
    def monthlyPoints
      @obj["monthlyPoints"].to_i
    end

    # Returns the total points of the bot
    # @return [Integer]
    def points
      @obj["points"].to_i
    end

    # Returns the Top.gg vanity URL code, can be nil
    # @return [String]
    def vanity
      @obj["vanity"]
    end

    # Returns the owner ids
    # @return [Array<String>]
    def owners
      @obj["owners"]
    end

    # Return the bot tags
    # @return [Array<String>]
    def tags
      @obj["tags"]
    end

    # Returns an object containing the bot's review information.
    # @return [Object]
    def reviews
      @obj["reviews"]
    end
  end
end
