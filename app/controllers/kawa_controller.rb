class KawaController < ApplicationController

  def self.inherited(klass)
    super
    klass.class_eval do
      before_filter :load_resource, :set_crumb, :only  => [:show, :edit, :update, :destroy]
    end
  end

  def index
    add_crumb model.to_s.pluralize

    ivar = "@#{model.to_s.downcase.pluralize}"

    if TagSearchPresenter.tag_search?(params)
      @search = TagSearchPresenter.new(model, params)
      add_crumb @search.search_tags
      instance_variable_set(ivar, @search.result)
    else
      instance_variable_set(ivar, model.all)
    end
  end

  def new
    add_crumb "New #{model.to_s}"
    instance_variable_set(model_singular_ivar, model.new)
  end

  def create
    if new_instance.save
      redirect_to new_instance, :notice  => "#{model.to_s} added successfully"
    else
      render :edit
    end
  end

  def edit
  end

  def update
    instance = instance_variable_get(model_singular_ivar)
    if instance.update_attributes(params[model_sym])
      redirect_to instance, :notice  => "#{model.to_s} updated successfully"
    else
      render :edit
    end
  end

  def destroy
    instance = instance_variable_get(model_singular_ivar)
    instance.destroy
    redirect_to send "#{model.to_s.downcase.pluralize}_path"
  end

  protected

  def load_resource
    ivar = model_singular_ivar
    instance_variable_set(ivar, model.find(params[:id]))
  end

  def model_singular_ivar
    "@#{model.to_s.downcase}".to_sym
  end

  def model
    self.class.to_s.gsub('Controller', '').singularize.constantize
  end

  def new_instance
    @new_instance ||= instance_variable_set(model_singular_ivar, model.new(params[model_sym]))
  end

  def model_sym
    model.to_s.downcase.singularize.to_sym
  end

  def set_crumb
    add_crumb model.to_s
  end

end
