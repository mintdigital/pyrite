namespace :grid do

  BROWSERS = {
    :safari_osx    => 'Safari on OS X',
    :firefox_osx   => 'Firefox on OS X',
    :firefox_xp    => 'Firefox on XP'
    :ie6           => 'IE6',
    :ie7           => 'IE7',
    :ie8           => 'IE8'
  }

  BROWSERS.each do |key, browser|
    desc "Run Pyrite browser tests with #{browser}"
    task key do
      ENV['BROWSER'] = browser
      ENV['SERVER_URL'] = 'http://192.168.200.141'
      Rake::Task['pyrite:run'].invoke
    end
  end

end
