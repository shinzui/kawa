Fabricator(:user) do
  email { sequence(:email) {|i| "user#{i}@kawa.com"} }
  password "password"
  password_confirmation "password"
end
