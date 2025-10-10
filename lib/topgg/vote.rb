module Dbl
  # A Top.gg vote information
  class Vote
    def initialize(obj)
      @obj = obj
    end

    # The raw hash of the parsed JSON object
    # @return [Hash]
    attr_reader :obj

    alias raw obj
    alias data obj

    # When the vote was cast
    # @return [Date]
    def voted_at
      Date.parse(@obj["created_at"])
    end

    # When the vote expires
    # @return [Date]
    def expires_at
      Date.parse(@obj["expires_at"])
    end

    # The vote's weight
    # @return [Integer]
    def weight
      @obj["weight"]
    end
  end
end