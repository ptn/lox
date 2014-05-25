require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../../lib/lox'

describe Lox::Handlers do
  describe "http_static_files" do
    it "reads the requested file" do
      server = stub(:root => 'root')
      client = stub(:recvfrom => ["GET /hi.txt HTTP/1.1", nil],
                    :puts => nil)

      File.expects(:read).with("root/hi.txt")

      Lox::Handlers.http_static_files(server, client)
    end

    it "reads index.html if no filename was found" do
      server = stub(:root => 'root')
      client = stub(:recvfrom => ["GET / HTTP/1.1", nil],
                    :puts => nil)

      File.expects(:read).with("root/index.html")

      Lox::Handlers.http_static_files(server, client)
    end
  end
end
