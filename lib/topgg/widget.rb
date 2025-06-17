module Dbl
  # Widget generator functions.
  class Widget
    @base_url = "https://top.gg/api/v1"

    class << self
      attr_accessor :base_url
  
      # Generates a large widget URL.
      # @param id [String] The ID.
      def large(id)
        "#{@base_url}/widgets/large/#{id}"
      end
    end
  end
end