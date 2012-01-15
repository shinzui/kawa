module Kawa
  module Kernel
    extend self

    def boot
      load_wiki_plugins
      setup
    end

    def setup
      ActionController::Base.send(:include, Kawa::Common::ViewContextFilter) if defined?(ActionController::Base)  
    end

    def load_wiki_plugins
      wiki_plugins.each do |plugin_class|
        Kawa::Wiki::Plugin::Registry.register(plugin_class.name, plugin_class)
      end
      Kawa::Wiki::Plugin::Registry.configured = true
    end

    def wiki_plugins
      plugins = []
      Dir.glob(File.join(Rails.root, "app/kawa/kawa/wiki/**/*.rb")).sort.each do |file|
        path_parts = file[0..-4].split('/')
        start_index = path_parts.rindex("kawa")
        path = path_parts.slice(start_index..-1)
        plugin = path.map(&:camelize).join("::").constantize
        if plugin.is_a?(Class) && plugin.superclass == Kawa::Wiki::Plugin::WikiPlugin
          plugins << plugin
        end
      end

      plugins
    end
  end
end
