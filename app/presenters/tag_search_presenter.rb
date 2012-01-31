class TagSearchPresenter
  include Kawa::Common::Presenter
  attr_reader :tags

  def self.tag_search?(params)
    params[:tag].present? || params[:tags].present?
  end

  def initialize(model, params)
    @model = model
    if params[:tag]
      @tags = [params[:tag]]
    end

    if params[:tags]
      @tags = params[:tags]
    end
  end

  def search_tags
    @tags.join(" and ")
  end

  def result
    @result ||= @model.all_in(tags_array: @tags).desc(:updated_at)
  end

end
