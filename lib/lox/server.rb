module Lox
  class Server
    attr_reader :hostname, :port, :handler, :clients, :root

    def initialize(hostname, port, clients, root=nil, &handler)
      @hostname = hostname
      @port = port
      @clients = clients
      @root = root || Dir.pwd
      @handler = handler
    end

    def accept
      client = @clients.accept
      @handler.call(self, client)
      client.close
    end
  end
end
