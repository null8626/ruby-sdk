# frozen_string_literal: true
module Dbl
  # A Top.gg user
  class User
    # Instantiates the class variables
    # @param obj [Object] Response Data Object
    def initialize(obj)
      @obj = obj
    end

    # The raw hash of the parsed JSON object
    # @return [Hash]
    attr_reader :obj

    alias raw obj
    alias data obj
    
    # Check for errors, if any
    def error
      @obj["error"]
    end

    # The user's ID
    def id
      @obj["id"]
    end

    # The user's username
    def username
      @obj["username"]
    end

    # The user's avatar URL
    # @return [String]
    def avatar
      @obj["avatar"]
    end

    # The user's default avatar
    # @return [String]
    def defAvatar
      ""
    end

    # Whether the user is a moderator.
    # @return [Boolean]
    def mod
      false
    end

    # Whether the user is a Top.gg supporter.
    # @return [Boolean]
    def supporter
      false
    end

    # Whether the user is a certified developer.
    # @return [Boolean]
    def certifiedDev
      false
    end

    # The user's socials
    # @return [Object]
    def social
      nil
    end

    # Whether the user is an administrator.
    # @return [Boolean]
    def admin
      false
    end

    # Whether the user is a web moderator.
    # @return [Boolean]
    def webMod
      false
  end
end
