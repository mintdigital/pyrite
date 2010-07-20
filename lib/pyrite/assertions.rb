module Pyrite
  module Assertions

    # Assert some text appears somewhere on the page
    def assert_text(text, msg=nil)
      assert browser.text?(text), msg || "Text '#{text}' not found on page"
    end

    # Assert some text does not appear somewhere on the page
    def assert_no_text(text, msg=nil)
      assert !browser.text?(text), msg || "Text '#{text}' not found on page"
    end

    # Assert an element appears on the page via jquery selector
    def assert_element(selector, msg=nil)
      assert browser.element?("jquery=#{selector}"),
        msg || "Element '#{selector}' not found on page"
    end

    # Assert an element does not appear on the page via jquery selector
    def assert_no_element(selector, msg=nil)
      assert !browser.element?("jquery=#{selector}"),
        msg || "Element '#{selector}' was found on page but shouldn't be"
    end
  end
end
