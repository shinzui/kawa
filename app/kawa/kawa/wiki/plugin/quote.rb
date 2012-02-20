require 'quote'

module Kawa
  module Wiki
    module Plugin
      class Quote < WikiPlugin
        include RenderingPlugin

        def process(options = {})
          ::QuotePresenter.new(::Quote.random).quote
        end
      end
    end
  end
end
