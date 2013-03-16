class TagSearchPresenter
  include Kawa::Common::Presenter
  attr_reader :tags, :params

  def initialize(model, params, opts = {})
    @model = model
    if params[:tag]
      @tags = [params[:tag]]
    end

    if params[:tags]
      @tags = params[:tags].first.split(",")
    end

    @params = params.dup
    @paginate = opts.delete(:paginate)
  end

  def self.tag_search?(params)
    params[:tag].present? || params[:tags].present?
  end

  def search_tags
    @tags.join(" and ")
  end

  def result
    @result ||= begin
      r = @model.all_in(tags: @tags).desc(:updated_at)
      r = r.page params[:page] if @paginate
      r
    end
  end

end
