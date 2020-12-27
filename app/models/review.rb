class Review < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1200 }
  enum status: { "draft": 0, "published": 1 }
  validates :status, inclusion: { in: Review.statuses.keys }

  belongs_to :user
  belongs_to :book ,primary_key: "isbn"

  has_many :comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :favored, through: :favorites, source: :user

  has_many :notifications, dependent: :destroy

  def create_notification_favorite(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      notification.save if notification.valid?
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(review_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id["user_id"])
    end
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      review_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    
    notification.save if notification.valid?
  end

  def toggle_status!
    draft? ? published : draft
  end
end