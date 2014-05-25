require 'socket'

require_relative 'lox/server'

module Lox
  DEFAULT_PORT = 4555

  def self.new(hostname, port, &blk)
    backend = TCPServer.new(hostname, port)
    Server.new(hostname, port, backend, &blk)
  end

  def self.run(hostname, port, &blk)
    new(hostname, port, &blk).accept
  end
end
