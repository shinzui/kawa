class Quote 
  include Snippet

  alias :quotation :data
  alias :quotation= :data=

  label :author, :source, :source_url

end
