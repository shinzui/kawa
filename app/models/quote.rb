class Quote < Snippet

  alias :quotation :data
  alias :quotation= :data=

  def author
    labels["author"]
  end

  def author=(author)
    set_label("author", author)
  end

  def source
    labels["source"]
  end
  
  def source=(source)
    set_label("source", source)
  end

end
