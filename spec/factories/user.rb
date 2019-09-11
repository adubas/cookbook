FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "nome#{n}@email.com"}
    password { "457878" }
  end
end
