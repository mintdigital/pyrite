require 'selenium/rake/tasks'
require 'selenium_remote_control'

namespace :selenium do
  Selenium::Rake::RemoteControlStartTask.new(:start) do |rc|
    rc.port = 4444
    rc.timeout_in_seconds = 3 * 60
    rc.background = true
    rc.wait_until_up_and_running = true
    rc.log_to = 'log/selenium_rc.log'
    rc.jar_file = SeleniumRC.jar_file
  end

  Selenium::Rake::RemoteControlStopTask.new(:stop) do |rc|
    rc.host = "localhost"
    rc.port = 4444
    rc.timeout_in_seconds = 3 * 60
  end
end
