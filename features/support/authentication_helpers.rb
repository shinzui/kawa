module AuthenticationHelpers
  include Devise::TestHelpers
  include Warden::Test::Helpers

  def as_user(user = nil)
    current_user = user || Fabricate(:user)
    login_as(current_user, :scope  => :user)
    @logged_in_user = current_user
    yield if block_given?
  end
  alias_method :login_user, :as_user

  def as_visitor
    logout(:user)
    @logged_in_user = nil

    yield if block_given?
  end
  alias_method :logout_user, :as_visitor

  def logged_in_user
    @logged_in_user
  end
end

World(AuthenticationHelpers)
