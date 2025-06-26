module Dbl
  class Vote
    def initialize(obj)
      @obj = obj
    end

    # Returns raw hash of the parsed json object
    # @return [Hash]
    attr_reader :obj

    alias raw obj
    alias data obj

    # Returns the ID of the Discord bot/server that received a vote.
    # @return [String]
    def receiver_id
      !@obj["bot"].nil? ? @obj["guild"] : @obj["bot"]
    end

    # Returns the ID of the Top.gg user who voted.
    # @return [String]
    def voter_id
      @obj["user"]
    end

    # Returns whether this vote is just a test done from the page settings.
    # @return [Boolean]
    def is_test
      @obj["type"] == "test"
    end

    # Returns whether the weekend multiplier is active, where a single vote counts as two.
    # @return [Boolean]
    def is_weekend
      @obj["isWeekend"] == true
    end

    # Returns query strings found on the vote page.
    # @return [Hash<String, String>]
    def query
      return nil if @obj["query"].nil?

      CGI.parse(@obj["query"]).transform_values(&:first)
    end
  end
end