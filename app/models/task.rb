class Task < ApplicationRecord
  validates :name, :content, presence: true
  belongs_to :user
  enum status:{
    未着手: 0, 着手中: 1,完了: 2
  }
  enum priority:{
    低: 0, 中: 1, 高: 2
  }
  scope :search_name, -> (params){where('name LIKE ?', "%#{params}%")}
  scope :search_status, -> (params){where(status: params)}
  scope :sort_end_date, -> {order(end_date: :desc)}
  scope :sort_priority, -> {order(priority: :desc)}
end
