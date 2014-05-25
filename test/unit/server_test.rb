require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../../lib/lox'

describe Lox::Server do
  it "should accept a stream of clients" do
    clients = stub
    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, clients)
    server.clients.must_equal clients
  end

  it "should know its hostname and port" do
    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, stub)
    server.hostname.must_equal 'localhost'
    server.port.must_equal Lox::DEFAULT_PORT
  end

  it "should record the handler code to run on every client" do
    handler = proc { puts "hi" }
    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, stub, &handler)
    assert_equal server.handler, handler
  end

  it "delegates accepting a connection to its backend server" do
    clients = mock
    clients.expects(:accept).returns(stub(:close => nil))

    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, clients) {}
    server.accept
  end

  it "runs the handler after accepting a client" do
    handler = proc { puts "hi" }
    handler.expects(:call)

    clients = stub(:accept => stub(:close))
    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, clients, &handler)
    server.accept
  end
end
