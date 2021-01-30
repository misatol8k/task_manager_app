class Task < ApplicationRecord
  validates :name, :content, presence: true
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  enum status:{
    未着手: 0, 着手中: 1,完了: 2
  }
  enum priority:{
    低: 0, 中: 1, 高: 2
  }
  scope :selected,  -> { select(:name, :content, :created_at, :end_date, :status, :priority, :id, :user_id) }
  scope :search_name, -> (params){where('name LIKE ?', "%#{params}%")}
  scope :search_status, -> (params){where(status: params)}
  scope :sort_end_date, -> {order(end_date: :desc)}
  scope :sort_priority, -> {order(priority: :desc)}
end
