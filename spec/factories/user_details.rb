FactoryBot.define do # 重複しないデータを作成
  factory :user_detail do
    name{ Faker::Name,name}
    sequence(:account) { |n| "#{n}_#{Faker::Internet.username}"}
    sequence(:email) { |n| "#{n}_#{Faker::Internet.email}"}

    trait :with_user_detail do #ファクトリーの場合わけ
      user_detail
    end
  end
end
