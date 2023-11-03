require 'bunny'

module Publishers
  class Application
    def initialize(message:, exchange_name:, routing_key:)
      @message = message
      @exchange = exchange_name
      @routing_key = routing_key
    end

    def perform
      connection.start
      channel = connection.create_channel
      direct_exchange = channel.direct(exchange)
      direct_exchange.publish(message.to_json, routing_key: routing_key)
      connection.close
    end

    attr_reader :message, :exchange, :routing_key

    private

    def connection_options
      {
        host: "localhost",
        port: "5672",
        vhost: "/",
        username: "guest",
        password: "guest"
      }
    end

    def connection
      @connection ||= Bunny.new(connection_options)
    end
  end
end
