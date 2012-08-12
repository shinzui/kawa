class ApplicationController < ActionController::Base
  before_filter :configure_sidebar
  protect_from_forgery

  add_crumb "Home", "/" 

  def wiki
    Kawa::Wiki::Engine.instance
  end

  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user
    guest_user_id = session[:guest_user_id]
    if guest_user_id
      guest = User.where(:_id  => guest_user_id).first
    else
      guest = User.new(:email  => "guest_#{Time.now.to_i}#{rand(99)}@#{request.host}")
      guest.save(:validate  => false)
      session[:guest_user_id] = guest.id
    end
    guest
  end

  def authority_forbidden(exception)
    flash[:error] = "You do not have access to this resource"
    redirect_to root_url
  end

  private
    def configure_sidebar
      @sidebar = SidebarPresenter.new
    end
end
