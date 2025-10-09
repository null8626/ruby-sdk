module Dbl
  # A Discord bot's statistics
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
    # The bot's server count
    # @return [Integer]
    def server_count
      @obj['server_count']
    end

    # The bot's server count in each shard
    # @return [Integer]
    def shards
      @obj['shards']
    end

    # The bot's shard count
    # @return [Integer]
    def shard_count
      @obj['shard_count']
    end
  end
end