class User < ApplicationRecord
  after_update :admin_exist
  before_destroy :admin_cannot_destroy_self
  after_destroy :admin_exist
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  scope :selected,  -> { select(:name, :email, :admin, :created_at, :updated_at, :id) }

  private
  def admin_cannot_destroy_self
    throw :abort if self.admin?
  end

  def admin_exist
    admin_count = User.where(admin: true).count
    if admin_count <= 0
      raise ActiveRecord::Rollback
    end
  end
end
