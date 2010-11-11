require 'selenium/client'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

require 'pyrite/pyrite_test'

module Pyrite
  # set the default JS framework for the AUT
  # e.g `Pyrite.js_framework = :jquery`
  # can be set in pyrite_helper.rb
  # Makes `wait_for :ajax` use the correct JS lib.
  # Defaults to jQuery.
  mattr_accessor :js_framework
  @@js_framework = :jquery

  # The ip address the RC is running on
  mattr_accessor :rc_host
  @@rc_host = ENV['RC_HOST'] || '0.0.0.0'

  # The url on which the test server will be booted
  mattr_accessor :server_url
  @@server_url = ENV['SERVER_URL'] || 'http://0.0.0.0'

  # The port on which the test server will be booted
  mattr_accessor :server_port
  @@server_port = ENV['SERVER_PORT'] || 2222

  # The browser that selenium will drive
  mattr_accessor :browser
  @@browser = ENV['BROWSER'] || '*chrome'

  # The timeout for Selenium::Client
  mattr_accessor :timeout
  @@timeout = 120
end
