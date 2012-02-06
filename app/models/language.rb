# encoding: UTF-8
#
# Represent a language as defined in ISO 639-1
# http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
class Language
  attr_reader :name, :native_name, :iso_code
  
  def initialize(name, native_name, iso_code)
    @name = name
    @native_name = native_name
    @iso_code = iso_code
  end

  def self.japanese
    @japanese ||= new("Japanese", "日本語", "ja")
  end

  def self.english
    @english ||= new("English", "English", "en")
  end

  def self.french
    @french ||= new("French", "Français", "fr")
  end

  def self.korean
    @korean ||= new("Korean", "한국어", "ko")
  end

  def self.supported
    [english, japanese, french, korean]
  end

end
