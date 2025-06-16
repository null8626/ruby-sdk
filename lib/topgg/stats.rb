module Dbl
  # The Stats class spreads the json response into different methods
  class Stats
    # Initializes the Stats class
    # @param obj [Object] Response Hash
    def initialize(obj)
      @obj = obj
    end

    # Returns raw Hash of the response
    attr_reader :obj

    alias raw obj

    alias data obj
    # Returns the server Count of the bot
    # @return [Integer]
    def server_count
      @obj["server_count"]
    end
  end
end
