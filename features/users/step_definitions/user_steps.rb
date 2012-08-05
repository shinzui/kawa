Given /^there is a user "(.*?)"$/ do |user_email|
  Fabricate(:user, :email  => user_email)
end

Given /^"(.*?)" is logged in$/ do |user_email|
  @user = User.where(:email  => user_email).first
  login_user @user
end


Given /^(?:he|she) edits (?:his|her) profile$/ do
  visit edit_user_path(@user)
  ozu = Fabricate.attributes_for(:ozu)
  fill_in "Username", :with  => ozu[:username] 
  fill_in "First name", :with  => ozu[:first_name]
  fill_in "Last name", :with  => ozu[:last_name]
  click_button :submit
end

Then /^the user profile should get updated$/ do 
  user = User.last
  ozu = Fabricate.attributes_for(:ozu)
  user.user_profile.first_name.should == ozu[:first_name]
  user.user_profile.last_name.should == ozu[:last_name]
  user.user_profile.username.should == ozu[:username]
end
