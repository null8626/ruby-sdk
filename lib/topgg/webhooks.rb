require "rack"
require "cgi"

require_relative "voteEvent"

module Dbl
  # A wrapper for directly receiving events from Top.gg's servers
  class Webhook
    VOTE = ->(json) { VoteEvent.new(json) }

    def initialize(app, type:, path:, auth:, &callback)
      raise ArgumentError, "A callback must be provided" unless callback
      raise ArgumentError, "A type must be provided" unless type.respond_to?(:call)
      
      @app = app
      @deserializer = type
      @path = path
      @auth = auth
      @callback = callback
    end
  
    def call(env)
      req = Rack::Request.new(env)
  
      if req.post? && req.path.start_with?(@path)
        if req.get_header('HTTP_AUTHORIZATION') != @auth
          return [401, { 'Content-Type' => 'text/plain' }, ['Unauthorized']]
        end
  
        body = req.body.read

        begin
          data = JSON.parse(body)
          
          @callback.call(@deserializer.call(data)) if data
          
          return [204, { 'Content-Type' => 'text/plain' }, ['']]
        rescue JSON::ParserError
          return [400, { 'Content-Type' => 'text/plain' }, ['Bad request']]
        end
      end
  
      @app.call(env)
    end
  end
end