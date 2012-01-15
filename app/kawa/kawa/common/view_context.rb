module Kawa
  module Common
    module ViewContext
      def self.current
        Thread.current[:current_view_context]
      end

      def self.current=(view_context)
        Thread.current[:current_view_context] = view_context  
      end
    end
  end
end
