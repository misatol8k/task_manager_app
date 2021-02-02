FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    content { 'RSpecでテストを書く' }
    end_date { '2021-01-16' }
    status { '未着手' }
    priority { '低' }
    association :user
    after(:create) do |task|
      create(:labeling, task: task, label: create(:label))
      create(:labeling, task: task, label: create(:second_label))
    end
  end
  factory :second_task, class: Task do
    name { 'タスク2-1' }
    content { 'テストを追加する' }
    end_date { '2021-01-15' }
    status { '着手中' }
    priority { '高' }
    association :user
    after(:create) do |task|
      create(:labeling, task: task, label: Label.second)
      create(:labeling, task: task, label: create(:third_label))
    end
  end
  factory :third_task, class: Task do
    name { 'タスク2-2' }
    content { 'テストを追加する' }
    end_date { '2021-01-14' }
    status { '未着手' }
    priority { '中' }
    association :user
    after(:create) do |task|
      create(:labeling, task: task, label: Label.last)
    end
  end
end
