Fabricator(:user) do
  email { sequence(:email) {|i| "user#{i}@kawa.com"} }
  password "password"
  password_confirmation "password"
end

Fabricator(:user_profile) do
  username { sequence(:username) {|i| "misaki#{i}"}}
  first_name "Misaki"
  last_name "Ito"
end

Fabricator(:ozu, :from  => :user) do
  email "ozu@gmail.com"
  user_profile { Fabricate.build(ozu_user_profile) }
end

Fabricator(:ozu_user_profile, :from  => :user_profile) do
  first_name "Yasujiro" 
  last_name "Ozu" 
  username "ozu" 
end
