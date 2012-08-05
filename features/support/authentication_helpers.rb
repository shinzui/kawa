module AuthenticationHelpers
  include Devise::TestHelpers
  include Warden::Test::Helpers

  def as_user(user = nil)
    current_user = user || Fabricate(:user)
    login_as(current_user, :scope  => :user)
    yield if block_given?
  end
  alias_method :login_user, :as_user

  def as_visitor
    logout(:user)

    yield if block_given?
  end
  alias_method :logout_user, :as_visitor
end

World(AuthenticationHelpers)
