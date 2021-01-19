FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    content { 'RSpecでテストを書く' }
  end
  factory :second_task, class: Task do
    name { 'タスク2' }
    content { 'テストを追加する' }
  end
end
