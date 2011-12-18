class Page
  include Mongoid::Document
  
  field :name
  field :canonical_name
  field :format
  field :raw_data


end
