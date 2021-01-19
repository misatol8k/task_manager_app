FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    content { 'RSpecでテストを書く' }
    end_date { '2021-01-16' }
  end
  factory :second_task, class: Task do
    name { 'タスク2' }
    content { 'テストを追加する' }
    end_date { '2021-01-15' }
  end
end
