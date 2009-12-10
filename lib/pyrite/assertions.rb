module Pyrite
  module Assertions

    # Assert some text appears somewhere on the page
    def assert_text(text, msg=nil)
      assert browser.text?(text), msg || "Text '#{text}' not found on page"
    end

    # Assert an element appears on the page via CSS selector
    def assert_element(selector, msg=nil)
      assert browser.element?("css=#{selector}"),
        msg || "Element '#{selector}' not found on page"
    end

    # Assert an element does not appear on the page via CSS selector
    def assert_no_element(selector, msg=nil)
      assert !browser.element?("css=#{selector}"),
        msg || "Element '#{selector}' was found on page but shouldn't be"
    end
  end
end
