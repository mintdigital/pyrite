module Pyrite
  class PyriteTest < ActionController::IntegrationTest
    include Dsl
    include Assertions
    include Helpers

    self.use_transactional_fixtures = false

    def browser
      $browser ||= Selenium::Client::Driver.new(
        :host => Pyrite.rc_host,
        :port => 4444,
        :browser => Pyrite.browser,
        :url => "#{Pyrite.sever_url}:#{Pyrite.server_port}",
        :timeout_in_second => Pyrite.timeout
      )
    end

    def setup
      DatabaseCleaner.clean
      browser.start_new_browser_session
      super
    end

    def teardown
      super
      browser.close_current_browser_session
    end
  end
end
