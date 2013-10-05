class PageForm < BasicObject
  undef_method :==

  def initialize(page = ::Page.new)
    @page = page
  end

  def attributes=(attributes)
    attributes.each { |k,v| send("#{k}=", v) }
  end

  def attachment_ids=(attachment_ids)
    @page.attachment_ids = attachment_ids.values
  end

  def method_missing(method_name, *args, &block)
    @page.send(method_name, *args, &block)
  end

  def respond_to?(method_name, include_all = false)
    @page.respond_to? method_name
  end
  
  def respond_to_missing?(method_name)
    @page.respond_to_missing(method_name)
  end

  def send(symbol, *args)
    __send__ symbol, *args
  end

end
