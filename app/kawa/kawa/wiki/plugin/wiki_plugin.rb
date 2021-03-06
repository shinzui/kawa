module Kawa
  module Wiki
    module Plugin
      class WikiPlugin
        attr_reader :page

        def initialize(page)
          @page = page
        end

        def inline_template(file)
          IO.read(file).gsub("\r\n", "\n").split(/^__END__$/, 2)[1]
        end

        def self.name
          to_s.demodulize.gsub(/plugin$/, '').underscore 
        end

        def name
          self.class.name
        end
      end
    end
  end
end
