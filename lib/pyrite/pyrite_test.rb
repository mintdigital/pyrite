require 'pyrite/dsl'
require 'pyrite/assertions'
require 'pyrite/helpers'

module Pyrite
  class PyriteTest < ActionController::IntegrationTest
    include Dsl
    include Assertions
    include Helpers

    self.use_transactional_fixtures = false

    def browser #:nodoc:
      $browser ||= Selenium::Client::Driver.new(
        :host => Pyrite.rc_host,
        :port => 4444,
        :browser => Pyrite.browser,
        :url => "#{Pyrite.sever_url}:#{Pyrite.server_port}",
        :timeout_in_second => Pyrite.timeout
      )
    end

    def setup #:nodoc:
      DatabaseCleaner.clean
      browser.start_new_browser_session
      browser.get_eval "window.moveTo(1,0)"
      browser.window_maximize
      browser.add_location_strategy("jquery",
                  "var loc = locator; " +
                  "var attr = null; " +
                  "var isattr = false; " +
                  "var inx = locator.lastIndexOf('@'); " +

                  "if (inx != -1){ " +
                  "   loc = locator.substring(0, inx); " +
                  "   attr = locator.substring(inx + 1); " +
                  "   isattr = true; " +
                  "} " +

                  "var found = jQuery(inDocument).find(loc); " +
                  "if (found.length >= 1) { " +
                  "   if (isattr) { " +
                  "       return found[0].getAttribute(attr); " +
                  "   } else { " +
                  "       return found[0]; " +
                  "   } " +
                  "} else { " +
                  "   return null; " +
                  "}"
              )
      super
    end

    def teardown #:nodoc:
      super
      browser.close_current_browser_session
    end
  end
end
