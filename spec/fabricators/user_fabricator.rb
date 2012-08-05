Fabricator(:user) do
  email { sequence(:email) {|i| "user#{i}@kawa.com"} }
  password "password"
  password_confirmation "password"
end

Fabricator(:ozu, :from  => :user) do
  email "ozu@gmail.com"
  first_name "Yasujiro"
  last_name "Ozu"
  username "ozu"
end
