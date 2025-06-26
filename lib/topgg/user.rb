# frozen_string_literal: true
module Dbl
  # The User class, used for Spreading the response body into different methods
  class User
    # Instantiates the class variables
    # @param obj [Object] Response Data Object
    def initialize(obj)
      @obj = obj
    end

    # Get raw hash response
    # @return [Hash]
    attr_reader :obj

    alias raw obj
    alias data obj
    
    # Check for errors, if any
    def error
      @obj["error"]
    end

    # The Id of the user
    def id
      @obj["id"]
    end

    # The username of the user
    def username
      @obj["username"]
    end

    # The avatar of the user
    # @return [String]
    def avatar
      @obj["avatar"]
    end
  end
end
