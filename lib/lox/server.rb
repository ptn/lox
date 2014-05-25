module Lox
  class Server
    attr_reader :hostname, :port, :handler, :clients

    def initialize(hostname, port, clients, &handler)
      @hostname = hostname
      @port = port
      @clients = clients
      @handler = handler
    end

    def accept
      client = @clients.accept
      @handler.call(client)
      client.close
    end
  end
end
