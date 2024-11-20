FactoryBot.define do
  factory :user do
    name { 'Alice' }
    sequence(:email_address) { |n| "person#{n}@example.com" }
    password { 'password' }
  end
end
