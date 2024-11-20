FactoryBot.define do
  factory :task do
    user_id { nil }
    title { 'お茶を買う' }
    executor_id { nil }
    memo { 'メモです。' }
    completed_at { nil }
  end
end
