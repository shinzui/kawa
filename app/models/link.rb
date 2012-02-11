class Link < Snippet
  alias :url :data
  alias :url= :data=

  label :title, :description
end
