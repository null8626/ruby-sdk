module Dbl
  # Widget generator functions.
  class Widget
    @base_url = "https://top.gg/api/v1"

    class << self
      attr_accessor :base_url

      TYPES = [:discord_bot, :discord_server]
  
      # Generates a large widget URL.
      # @param ty [Symbol] The widget type.
      # @param id [String] The ID.
      def large(ty, id)
        raise ArgumentError, "Invalid widget type" unless TYPES.include?(ty)
        type = ty.to_s.gsub('_', '/')

        "#{@base_url}/widgets/large/#{type}/#{id}"
      end

      # Generates a small widget URL for displaying votes.
      # @param ty [Symbol] The widget type.
      # @param id [String] The ID.
      def votes(ty, id)
        raise ArgumentError, "Invalid widget type" unless TYPES.include?(ty)
        type = ty.to_s.gsub('_', '/')

        "#{@base_url}/widgets/small/votes/#{type}/#{id}"
      end

      # Generates a small widget URL for displaying a project's owner.
      # @param ty [Symbol] The widget type.
      # @param id [String] The ID.
      def owner(ty, id)
        raise ArgumentError, "Invalid widget type" unless TYPES.include?(ty)
        type = ty.to_s.gsub('_', '/')

        "#{@base_url}/widgets/small/owner/#{type}/#{id}"
      end

      # Generates a small widget URL for displaying social stats.
      # @param ty [Symbol] The widget type.
      # @param id [String] The ID.
      def social(ty, id)
        raise ArgumentError, "Invalid widget type" unless TYPES.include?(ty)
        type = ty.to_s.gsub('_', '/')
        
        "#{@base_url}/widgets/small/social/#{type}/#{id}"
      end
    end
  end
end