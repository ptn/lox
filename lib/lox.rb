require 'socket'

require_relative 'lox/server'
require_relative 'lox/handlers'

module Lox
  DEFAULT_PORT = 4555

  def self.new(hostname, port, root=nil, &blk)
    backend = TCPServer.new(hostname, port)
    Server.new(hostname, port, backend, root, &blk)
  end

  def self.run(hostname, port, root=nil, &blk)
    server = new(hostname, port, root, &blk)
    loop { server.accept }
  end
end
