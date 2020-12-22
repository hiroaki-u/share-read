class User < ApplicationRecord

  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  enum gender: { "男性": 1, "女性": 2 }
  has_many :reviews
end