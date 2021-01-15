class Task < ApplicationRecord
  validates :name, :content, presence: true
end
