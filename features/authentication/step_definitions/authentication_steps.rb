Given /^A logged in user$/ do
  login_user
end

Given(/^I visit the sign in page$/) do
  visit new_user_session_path
end

Given(/^I enter valid credentials$/) do
  @user = Fabricate(:user)
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: "password"
  click_button "Sign in"
end

Then(/^I should be signed in$/) do
  page.should have_link(@user.email)
  page.should have_content("Sign out")
end
