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

  it "should accept a root dir" do
    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, stub, 'files')
    server.root.must_equal 'files'
  end

  it "should pick up the current working dir as its default root dir" do
    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, stub)
    server.root.must_equal Dir.pwd
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

  it "runs the handler after accepting a client with itself as a param too" do
    client = stub(:close)
    clients = stub(:accept => client)
    handler = proc { puts "hi" }
    server = Lox::Server.new('localhost', Lox::DEFAULT_PORT, clients, &handler)

    handler.expects(:call).with do |handler_server, handler_client|
      handler_server.must_equal server
      handler_client.must_equal client
    end

    server.accept
  end
end
