module Kawa
  module Common
    module ViewContextFilter
      def set_current_view_context
        Kawa::Common::ViewContext.current = self.view_context
      end

      def self.included(base)
        base.send(:before_filter, :set_current_view_context)
      end
    end
  end
end
