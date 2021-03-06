Factory.define :user do |u|
  u.sequence(:login) { |n| "username-#{n}" }
  u.sequence(:email) { |n| "dummy#{n}@tryphon.org" }

  password = "password"
  u.password password
  u.password_confirmation password

  u.activated_at Time.now
end

Factory.define :show do |u|
  u.sequence(:slug) { |n| "slug-#{n}" }
  u.name "name"
  u.description "description"
  u.users { |users| [users.association(:user)] }
end
  
Factory.define :post do |u|
  u.sequence(:slug) { |n| "slug-#{n}" }
  u.title "name"
  u.description "description"
  u.association :show
end
  
