namespace :pyrite do
  Rake::TestTask.new(:run) do |t|
    t.libs << "test"
    t.pattern = 'pyrite/tests/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['pyrite:run'].comment = "Full-stack in-browser tests with pyrite"

    desc "Startup Selenium RC and the server for browser testing"
    task :start do
      Rake::Task['selenium:start'].invoke
      puts `thin start -e selenium -p 2222 -d`
    end

    desc "Shutdown Selenium RC and the server for browser testing"
    task :stop do
      begin
        Rake::Task['selenium:stop'].invoke
      rescue Errno::ECONNREFUSED => boom
        puts "*** Could not connect to Selenium RC. Assuming it is not running."
      end
      if File.exist?(pidfile = 'tmp/pids/server.pid')
        puts "Stopping server process #{pid = File.read(pidfile)}"
        Process.kill 'QUIT', Integer(pid)
      else
        puts "*** Could not read pid file for server. Assuming it is not running."
      end
    end

namespace :pyrite do

    BROWSERS = {
      :safari_osx    => 'Safari on OS X',
      :firefox_osx   => 'Firefox on OS X',
      :ie_xp         => 'IE on XP',
      :ie_vista      => 'IE on Vista',
      :firefox_vista => 'Firefox on Vista',
      :firefox_xp    => 'Firefox on XP'
    }
    task :grid do
      errors = BROWSERS.keys.collect do |key|
        task = "test:grid:#{key}"
        begin
          Rake::Task[task].invoke
          nil
        rescue => e
          task
        end
      end.compact
      abort "Errors running #{errors.to_sentence(:locale => :en)}!" if errors.any?
    end
  end

  namespace :grid do
    BROWSERS.each do |key, browser|
      desc "Run browser tests for #{browser} through the Grid"
      task key do
        ENV['BROWSER'] = browser
        Rake::Task['test:browser'].invoke
      end
    end
  end

end
