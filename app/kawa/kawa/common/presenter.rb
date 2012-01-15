module Kawa
  module Common
    module Presenter
      def helpers
        ViewContext.current
      end
      alias :h :helpers
    end
  end
end
