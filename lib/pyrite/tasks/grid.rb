namespace :grid do

  BROWSERS  = {
    :ie8    => {:rc_host => '192.168.200.142', :browser => '*iexploreproxy'},
    :ie7    => {:rc_host => '192.168.200.145', :browser => '*iexploreproxy'},
    :ie6    => {:rc_host => '192.168.200.163', :browser => '*iexploreproxy'},
    :ff_xp  => {:rc_host => '192.168.200.163', :browser => '*chrome'},
    :ff_osx => {:rc_host => '192.168.200.117', :browser => '*chrome'},
    :sf_osx => {:rc_host => '192.168.200.117', :browser => '*safari'}
  }

  BROWSERS.each do |key, opts|
    desc "Run Pyrite browser tests in a browser"
      task key do
        ENV['RC_HOST']    = opts[:rc_host]
        ENV['BROWSER']    = opts[:browser]
        ENV['SERVER_URL'] = 'http://192.168.200.141'
        Rake::Task['pyrite:run'].invoke
      end
    end
    
    desc "Prepare server"
    task :start do
      pidfile = 'tmp/pids/server.pid'
      if File.exist?(pidfile)
        puts "Stopping server process #{pid = File.read(pidfile)}"
        Process.kill 'QUIT', Integer(pid)
      end
      %x{./script/server -p 2222 -e selenium -d} 
    end

    desc "Kill server"
    task :stop do
      if File.exist?(pidfile = 'tmp/pids/server.pid')
        puts "Stopping server process #{pid = File.read(pidfile)}"
        Process.kill 'QUIT', Integer(pid)
      end
    end

end
