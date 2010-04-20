namespace :pyrite do
  Rake::TestTask.new(:run) do |t|
    t.libs << "test"
    t.pattern = 'test/pyrite/**/*_test.rb'
    t.verbose = true
  end
  task :run # stub so that below will work
  Rake::Task['pyrite:run'].comment = "Full-stack in-browser tests with pyrite"

  desc "Startup Selenium RC and the server for browser testing"
  task :start => 'selenium:start' do
    puts `script/server -p 2222 -e pyrite -d`
  end

  desc "Shutdown Selenium RC and the server for browser testing"
  task :stop do
    begin
      Rake::Task['selenium:stop'].invoke
    rescue Errno::ECONNREFUSED => boom
      puts "*** Could not connect to Selenium RC. Assuming it is not running."
    end
    if File.exist?(pidfile = Rails.root+'tmp/pids/server.pid')
      puts "Stopping server process #{pid = File.read(pidfile)}"
      Process.kill 'QUIT', Integer(pid)
    else
      puts "*** Could not read pid file for server. Assuming it is not running."
    end
  end

    desc "Start, run then stop pyrite"
    task :all do
      Rake::Task['pyrite:start'].invoke
      Rake::Task['pyrite:run'].invoke
      Rake::Task['pyrite:stop'].invoke
    end
end
