begin
  require 'selenium/rake/tasks'
rescue LoadError => boom
else

  namespace :selenium do
    Selenium::Rake::RemoteControlStartTask.new(:start) do |rc|
      rc.port = 4444
      rc.timeout_in_seconds = 3 * 60
      rc.background = true
      rc.wait_until_up_and_running = true
      rc.log_to = 'log/selenium_rc.log'
      rc.additional_args << "-singleWindow"
      rc.jar_file = File.join(File.dirname(__FILE__),'..',
        'vendor','selenium-rc','selenium-server-1.0.2-SNAPSHOT-standalone.jar')
    end

    Selenium::Rake::RemoteControlStopTask.new(:stop) do |rc|
      rc.host = "localhost"
      rc.port = 4444
      rc.timeout_in_seconds = 3 * 60
    end
  end

end
