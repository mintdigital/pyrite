module Pyrite
  module Dsl

    # Fill in a form field
    def fill_in(element, value)
      if element.match /date/ # Try to guess at date selects
        select_date(element, value)
      else
        browser.type(element, value)
      end
    end

    # Fill in a Rails-ish set of date_select fields
    def select_date(element, value)
      suffixes = {
        :year   => '1i',
        :month  => '2i',
        :day    => '3i',
        :hour   => '4i',
        :minute => '5i'
      }
      date = value.respond_to?(:year) ? value : Date.parse(value)
      browser.select "#{element}_#{suffixes[:year]}", date.year
      browser.select "#{element}_#{suffixes[:month]}", date.strftime('%B')
      browser.select "#{element}_#{suffixes[:day]}", date.day
    end

    # Open a URL
    def visit(path)
      browser.open(path)
      wait_for :page_load
    end

    # Follow a link
    def follow(text)
      browser.click("link=#{text}")
    end

    # Press a button
    def press(text)
      browser.click("//input[@type='submit'][@value='#{text}']")
    end

    # Check a chek box or toggle a radio button 
    def check (locator)
      browser.check(locator)
    end

    # Click anything else
    def click(locator)
      browser.click(locator)
    end

    # Pick an option from a select element
    def select(element, option)
      browser.select(element, option)
    end

    # Wait for a specific element or the page to load
    def wait_for(element)
      if element == :page
        browser.wait_for_page_to_load
      else
        browser.wait_for_element(element)
      end
    end

    # Use this to consume JS alerts
    def get_confirmation
      browser.get_confirmation
    end


    # Capture the page and try to open it
    def show_me
      image = "#{Rails.root.join('tmp')}/pyrite-#{Time.now.to_i}.png"
      browser.capture_entire_page_screenshot(image, '')
    end
  end
end
