require 'selenium/client'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

module Pyrite

  # The port on which the test server will be booted
  mattr_accessor :server_port
  @@server_port = 2222

  # The url on which the test server will be booted
  mattr_accessor :sever_url
  @@sever_url = ENV['SERVER_URL'] || 'http://localhost'
  
  # The browser that selenium will drive
  mattr_accessor :browser
  @@browser = ENV['BROWSER'] || '*chrome'

  # The timeout for Selenium::Client
  mattr_accessor :timeout
  @@timeout = 60

end

require 'pyrite/pyrite_test'
