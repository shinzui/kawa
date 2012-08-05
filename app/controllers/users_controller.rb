class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user, :only  => [:edit, :update]

  def edit
    @user.build_user_profile unless @user.user_profile.present?
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice  => "Profile updated successfully"
    else
      render :edit
    end
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

end
