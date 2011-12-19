class Page
  include Mongoid::Document

  module Markup
    MARKDOWN = "markdown".freeze
    CREOLE   = "creole".freeze
  end
  
  field :name
  field :markup
  field :raw_data

  validates_presence_of :name, :markup, :raw_data
  validates_uniqueness_of :name

	def	self.supported_markups
		Markup.constants.map {|m| Markup.const_get(m)}
	end

  
end
