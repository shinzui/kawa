module Kawa
  module Wiki
    module Plugin
      MissingArgument = Class.new(StandardError)
      UnknownPlugin = Class.new(StandardError)
      
      module Registry
        extend self

        def register(name, klass)
          plugins[name]= klass
        end

        def plugins
          @plugins ||= {}
        end

        #Needed in development mode
        def ensure_configured
          return if @configured
          Kawa::Kernel.load_wiki_plugins
          @configured = true
        end

        def configured=(configured)
         @configured = configured  
        end

        def find(plugin_name)
          ensure_configured
          plugins[plugin_name]
        end

        def find!(plugin_name)
          plugin = find(plugin_name)
          raise UnknownPlugin.new("#{plugin_name} plugin is not registered") unless plugin
          plugin
        end
      end
    end
  end
end
