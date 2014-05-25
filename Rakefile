require_relative 'lib/lox'

task :test => ["test:unit", "test:integration"]

namespace "test" do
  task :unit do
    Dir["test/unit/*_test.rb"].each do |test|
      system "ruby #{test}"
    end
  end

  task :integration do
    pid = fork do
      Lox.run('localhost',
              Lox::DEFAULT_PORT,
              'files',
              &Lox::Handlers.method(:http_static_files))
    end

    if pid
      Dir["test/integration/*_test.rb"].each do |test|
        system "ruby #{test}"
      end

      result = Process.kill("KILL", pid)
      Process.wait
    end
  end
end
