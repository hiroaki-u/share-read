class User < ApplicationRecord

  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  enum gender: { "男性": 1, "女性": 2 }
  mount_uploader :user_image, UserImageUploader

  has_many :reviews

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_relationship, class: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverses_relationship, source: :user
  
  def follow(other_user)
    self.relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end