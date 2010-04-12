module Pyrite
  module Helpers

    # Easily get the path to a fixture file from Rails.root/test/fixtures/<filename>
    def fixture(filename)
      File.join(Rails.root,'test','fixtures', filename)
    end

  end
end
