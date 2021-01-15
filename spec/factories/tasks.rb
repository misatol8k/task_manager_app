FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    content { 'RSpecでテストを書く' }
  end
end
