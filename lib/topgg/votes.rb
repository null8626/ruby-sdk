module Dbl
  # This class Spreads the Vote response body into different methods.
  class Votes
    # Initializes the votes class
    # @param obj [Object] JSON parsed object
    def initialize(obj)
      @obj = obj
    end

    # Get raw hash return of the object
    # @return [Hash]
    attr_reader :obj

    alias raw obj

    alias data obj
    # Get the first vote amongst all the other votes, can be nil
    # @return [User]
    def first
      if @obj.empty?
        nil
      else
        User.new(@obj[0])
      end
    end

    # Returns the results array
    # @return [Array<User>]
    def results
      @obj.map { |u| User.new(u) }
    end

    # Get the total number of votes
    # @return [Integer]
    def total
      @obj.length
    end
  end
end
