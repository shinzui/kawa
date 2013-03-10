Given /^there is a user "(.*?)"$/ do |user_email|
  Fabricate(:user, :email  => user_email)
end

Given /^"(.*?)" is logged in$/ do |user_email|
  @user = User.where(:email  => user_email).first
  login_user @user
end

Given /^I am logged in as "(.*?)"$/ do |user_info|
  user = User.where(:email  => user_info).first
  user ||= User.where("user_profile.username"  => user_info).first
  if user.nil? && user_info =~ /@/
    user = Fabricate(:user, :email  => user_info)
  else
    user = Fabricate(:user, :user_profile  => Fabricate.build(:user_profile, :username  => user_info) )
  end

  login_user user
end


Given /^(?:he|she) edits (?:his|her) profile$/ do
  visit edit_user_path(@user)
  ozu = Fabricate.attributes_for(:ozu_user_profile)
  fill_in "Username", :with  => ozu[:username] 
  fill_in "First name", :with  => ozu[:first_name]
  fill_in "Last name", :with  => ozu[:last_name]
  click_button "Update User" 
end

Then /^the user profile should get updated$/ do 
  user = User.last
  ozu = Fabricate.attributes_for(:ozu_user_profile)
  user.user_profile.first_name.should == ozu[:first_name]
  user.user_profile.last_name.should == ozu[:last_name]
  user.user_profile.username.should == ozu[:username]
end
