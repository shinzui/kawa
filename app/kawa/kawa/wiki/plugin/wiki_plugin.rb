module Kawa
  module Wiki
    module Plugin

      class WikiPlugin
        attr_reader :page

        def initialize(page)
          @page = page
        end

        def self.name
          to_s.demodulize.underscore 
        end

        def name
          self.class.name
        end
      end
    end
  end
end
