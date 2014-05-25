require 'minitest/autorun'

require_relative '../../lib/lox'

describe Lox do
  before do
    @server_thread = Thread.new do
      server = Lox.run('localhost', Lox::DEFAULT_PORT) do |client|
        client.gets
      end
    end
  end

  it "should receive connections on a socket" do
    client = TCPSocket.new('localhost', Lox::DEFAULT_PORT)
    client.puts "Test"
    client.close
  end
end
