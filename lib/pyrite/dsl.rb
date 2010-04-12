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

    # Follow a link based on its text
    def follow(text)
      browser.click("link=#{text}")
    end

    # Press a button based on its text
    def press(text)
      browser.click("css=input[type=submit][value='#{text}']")      
    end

    # Check a chek box or toggle a radio button
    def check(locator)
      browser.check(locator)
    end

    # Click anything else
    def click(locator)
      browser.click("css=#{locator}")
    end

    # Pick an option from a select element
    def select(element, option)
      browser.select(element, option)
    end

    # Wait for a specific element or the page to load
    def wait_for(element)
      if element == :page_load
        browser.wait_for_page_to_load
      else
        browser.wait_for_element(element)
      end
    end

    # Wait for a frame with a give ID to finish loading
    def wait_for_frame(frame) 
      browser.wait_for_frame_to_load(frame, 5000)
    end

    # Excecute commands within an iframe, then switch back to the parent frame
    # i.e.
    #    inside_frame(iframe) do
    #      click "Submit"
    #    end
    def inside_iframe(frame)
      wait_for frame
      browser.select_frame(frame)
      wait_for_frame frame
      yield
      browser.select_frame("relative=parent")
    end

    # Use this to consume JS alerts
    # i.e.
    #    follow 'delete'
    #    get_confirmation
    #    !assert_element "h2:contains('user1')"
    def get_confirmation
      browser.get_confirmation
    end

    # drag an css selector to the center pixel of another, e.g. 
    # `drag_and_drop(:from => "li#element_#{my_oject.id}", :to => "div#trash")
    # ProTip: if you have a list of elements you wish to re-order, drag the top element down.
    def drag_and_drop(opts={})
      browser.drag_and_drop_to_object("css=#{opts[:from]}", "css=#{opts[:to]}")
    end

    # Capture the page and try to open it
    # (probably only works on os x)
    def show_me
      image = "#{Rails.root.join('tmp')}/pyrite-#{Time.now.to_i}.png"
      browser.capture_entire_page_screenshot(image, '')
      puts `open #{image}`
    end

  end

end