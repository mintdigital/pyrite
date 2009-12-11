namespace :test do
  Rake::TestTask.new(:browser) do |t|
    t.libs << "test"
    t.pattern = 'test/browser/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:browser'].comment = "Full-stack in-browser tests with pyrite"

  namespace :browser do
    desc "Startup Selenium RC and the server for browser testing"
    task :startup do
      Rake::Task['selenium:start'].invoke
      puts `script/server thin -e selenium -p 2222 -d`
    end

    desc "Shutdown Selenium RC and the server for browser testing"
    task :shutdown do
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

    BROWSERS = {
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
