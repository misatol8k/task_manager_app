FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    content { 'RSpecでテストを書く' }
    end_date { '2021-01-16' }
    status { '未着手' }
    priority { '低' }
  end
  factory :second_task, class: Task do
    name { 'タスク2-1' }
    content { 'テストを追加する' }
    end_date { '2021-01-15' }
    status { '着手中' }
    priority { '高' }
  end
  factory :third_task, class: Task do
    name { 'タスク2-2' }
    content { 'テストを追加する' }
    end_date { '2021-01-14' }
    status { '未着手' }
    priority { '中' }
  end
end
