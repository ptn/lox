require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../../lib/lox'

describe Lox do
  describe :new do
    it "creates a TCPServer" do
      TCPServer.expects(:new).with('localhost', Lox::DEFAULT_PORT)
      Lox.new('localhost', Lox::DEFAULT_PORT) {}
    end

    it "creates a server with a hostname, port, handler, an a TCPServer" do
      backend = stub
      TCPServer.stubs(:new).returns(backend)

      Lox::Server.expects(:new).with('localhost',
                                     Lox::DEFAULT_PORT,
                                     backend,
                                     nil)
      Lox.new('localhost', Lox::DEFAULT_PORT) {}
    end
  end
end
