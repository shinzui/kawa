module Kawa::Wiki::Plugin
  class Processor

    def initialize(page)
      @page = page
      @pluginmap = {}
    end

    def process_processing_plugins(data)
      process(data, ProcessingPlugin)
    end

    def preprocess_plugins(data)
      data.gsub!(/(.?)<<(.+?)>>/m) do
        if $1 == "'"
          "<<#{$2}>>"
        else
          stamp = Digest::SHA1.hexdigest($2)
          @pluginmap[stamp] = $2
          "#{$1}#{stamp}"
        end
      end
      data
    end

    def post_process_processing_plugins(data)
      post_process_plugins(data, ProcessingPlugin)
    end
    
    def post_process_rendering_plugins(data)
      post_process_plugins(data, RenderingPlugin)
    end

    private

    def process(data, plugin_type)
      data = preprocess_plugins(data)
      post_process_plugins(data, plugin_type)
    end

    def post_process_plugins(data, plugin_type)
      @pluginmap.each do |stamp, plugin|
        replacement = process_plugin(plugin, plugin_type)
        replacement ||= ""
        data.gsub!(stamp, replacement)
      end
      data
    end

    def process_plugin(plugin_text, plugin_type)
      if /(?<plugin_name>\w+)\s*(?<plugin_options>.+)/ =~ plugin_text
        plugin_class = Registry.find!(plugin_name)
        options = process_plugin_options(plugin_options)
        plugin = plugin_class.new(@page)
        plugin.process(options) if plugin.is_a?(plugin_type)
      else
      end
    end

    def process_rendering_plugin(plugin, options)
      
    end

    def process_plugin_options(plugin_options)
      tokens = plugin_options.scan(/(\w*)=\s*'(.*?)'/)
      Hash.new.tap do |options|
        tokens.each { |k,v| options[k.to_sym] = v }
      end
    end
  end
end
