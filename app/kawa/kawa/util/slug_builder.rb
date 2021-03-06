module Kawa
  module Util
    module SlugBuilder
      extend self

      def generate(string)
        result = string.strip_html_tags.convert_smart_punctuation.convert_accented_html_entities.convert_miscellaneous_html_entities.convert_miscellaneous_characters.collapse
        result.downcase.replace_whitespace("-").collapse("-")
      end
    end
  end
end
