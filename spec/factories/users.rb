FactoryBot.define do
  factory :user do
    name { "user_admin" }
    email { "test1@test.com" }
    password { "password" }
    admin { true }
  end
  factory :second_user, class: User do
    name { "user_b" }
    email { "test2@test.com" }
    password { "password" }
    admin { false }
  end
end
