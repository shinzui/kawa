# encoding: UTF-8
class UserPresenter
  include Kawa::Common::Presenter

  delegate :email, :to  => :@model
  attr_reader :model

  def initialize(user)
    @model = user
    self
  end

  def display_name
    return "" unless model
    if model.user_profile && model.user_profile.username
      model.user_profile.username
    else
      model.email
    end
  end

end
