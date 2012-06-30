module Kawa
  module Wiki
    module Plugin
      class Tag < WikiPlugin
        include ProcessingPlugin

        def process(options)
          values = options.delete(:values)
          raise MissingArgument.new("#{name} plugin requires values") unless values
          page.tags = values
          nil
        end
      end
    end
  end
end
