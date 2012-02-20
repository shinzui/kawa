require 'spec_helper'

module Kawa::Wiki::Plugin
  class MathJax < WikiPlugin
    include RenderingPlugin
  end

  class WebHook < WikiPlugin
    include ProcessingPlugin
  end

  class RandomQuote < WikiPlugin
    include RenderingPlugin
  end
end

module Kawa::Wiki::Plugin
  describe Processor do
    before :each do
      Registry.stub(:find!).with("mathjax").and_return(MathJax)
      Registry.stub(:find!).with("quote").and_return(RandomQuote)
      Registry.stub(:find!).with("webhook").and_return(WebHook)
      Registry.stub(:find!).with("some_plugin").and_raise(UnknownPlugin)

      @latex_option = "\frac{-b \pm \sqrt{b^2 - 4ac}}{2a}"
      @endpoint_option = "http://www.example.com/hook"

      @text =<<-EOF
        #Test

        [[Wiki Link]]

        <<quote >>

        <<mathjax latex='#{@latex_option}'>>

        <<webhook endpoint='#{@endpoint_option}'>> 
        EOF

        @processor = Processor.new(double('page'))
        @data = @processor.preprocess_plugins(@text)
    end

    describe "post processing" do
      shared_examples "missing plugin" do |processing_method|
        it "should raise an exception" do 
          text = "<<some_plugin value='test'>>"
          processor = Processor.new(double('page'))
          data = processor.preprocess_plugins(text)
          expect { processor.send(processing_method, data)}.to raise_error(UnknownPlugin)
        end
      end

      describe ".post_process_processing_plugins" do
        include_examples "missing plugin", :post_process_processing_plugins

        it "should only process non rendering plugins" do
          WebHook.any_instance.should_receive(:process).once.with(endpoint: @endpoint_option)
          @processor.post_process_processing_plugins(@data)
        end
      end

      describe ".post_process_rendering_plugins" do
        include_examples "missing plugin", :post_process_rendering_plugins

        it "should only process rendering plugins" do
          Kawa::Wiki::Plugin::MathJax.any_instance.should_receive(:process).once.with({latex: @latex_option})
          Kawa::Wiki::Plugin::RandomQuote.any_instance.should_receive(:process).once
          @processor.post_process_rendering_plugins(@data)
        end

        it "should process multiple plugins" do
          latex_out = "latex output"
          random_quote_out = "random quote"
          Kawa::Wiki::Plugin::MathJax.any_instance.should_receive(:process).once.with({latex: @latex_option}).and_return(latex_out)
          Kawa::Wiki::Plugin::RandomQuote.any_instance.should_receive(:process).once.and_return(random_quote_out)
          result = @processor.post_process_rendering_plugins(@data)
          result.should match /#{latex_out}/m
          result.should match /#{random_quote_out}/m
        end
      end
    end
  end
end

