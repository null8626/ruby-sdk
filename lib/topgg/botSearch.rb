# frozen_string_literal: true
module Dbl
  # A Discord bot search query
  class BotSearch
    # Initalizes the BotSearch class
    # @param obj [Object] Response Hash
    def initialize(obj)
      @obj = obj
    end

    # The raw hash of the parsed JSON object
    # @return [Hash]
    attr_reader :obj

    alias raw obj
    alias data obj

    # The Total number of results
    # @return [Integer]
    def total
      @obj["total"].to_i
    end

    # The first result, can be nil
    # @return [Bot]
    def first
      results = @obj["results"]
      
      if results.empty?
        nil
      else
        Bot.new(results[0])
      end
    end

    # The number of bots shown in the first page
    # @return [Integer]
    def count
      @obj["count"].to_i
    end

    # The number of bots skipped, can be nil
    # @return [Integer]
    def offset
      offset = @obj["offset"]

      if offset.nil?
        nil
      else
        offset.to_i
      end
    end

    # The results array
    # @return [Array<Bot>]
    def results
      @obj["results"].map { |b| Bot.new(b) }
    end

    # The length of the results
    # @return [Integer]
    def size
      @obj["results"].length
    end
  end
end
