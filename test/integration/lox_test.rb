require 'minitest/autorun'

require_relative '../../lib/lox'

describe Lox do
  it "should receive connections on a socket" do
    client = TCPSocket.new('localhost', Lox::DEFAULT_PORT)
    client.puts "GET / HTTP/1.1"
    client.close
  end

  it "should return file contents requested via http" do
    client = TCPSocket.new('localhost', Lox::DEFAULT_PORT)
    client.puts "\
GET /test_file.txt HTTP/1.1
    "
    actual = client.recv(300)
    client.close

    expected = File.read('files/test_file.txt')

    actual.must_equal expected
  end
end
