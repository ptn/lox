module Lox
  module Handlers
    def self.http_static_files(server, client)
      req = client.recvfrom(300)[0]
      fname = req.split[1]
      fname = fname == "/" ? "index.html" : fname
      path = File.join(server.root, fname)
      contents = File.read(path)

      client.puts(contents)
    end
  end
end
