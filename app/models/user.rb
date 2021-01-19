# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  enum gender: { "男性": 1, "女性": 2 }
  mount_uploader :user_image, UserImageUploader

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow

  has_many :reverses_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_relationship, source: :user

  has_many :favorites, dependent: :destroy
  has_many :favorings, through: :favorites, source: :review

  has_many :bookcases, dependent: :destroy
  has_many :register_books, through: :bookcases, source: :book

  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  def feed_reviews
    Review.where(user_id: following_ids + [id]).includes(:user, :book)
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def favor(other_review)
    favorites.find_or_create_by(review_id: other_review.id)
  end

  def unfavor(other_review)
    favorite = favorites.find_by(review_id: other_review.id)
    favorite&.destroy
  end

  def favoring?(other_review)
    favorings.include?(other_review)
  end

  def register(other_book)
    bookcases.find_or_create_by(book_id: other_book.isbn)
  end

  def unregister(other_book)
    bookcase = bookcases.find_by(book_id: other_book.isbn)
    bookcase&.destroy
  end

  def register?(other_book)
    register_books.include?(other_book)
  end

  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    return unless temp.blank?

    notification = current_user.active_notifications.new(
      visited_id: id,
      action: "follow"
    )
    notification.save if notification.valid?
  end
end
