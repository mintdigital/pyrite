namespace :grid do

  BROWSERS = {
    :safari_osx    => 'Safari on OS X',
    :firefox_osx   => 'Firefox on OS X',
    :ie_xp         => 'IE on XP',
    :ie_vista      => 'IE on Vista',
    :firefox_vista => 'Firefox on Vista',
    :firefox_xp    => 'Firefox on XP'
  }

  BROWSERS.each do |key, browser|
    desc "Run Pyrite browser tests with #{browser}"
    task key do
      ENV['BROWSER'] = browser
      Rake::Task['pyrite:run'].invoke
    end
  end

end
