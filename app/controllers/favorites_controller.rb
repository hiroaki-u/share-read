class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_review

  def create
    review = @review
    current_user.favor(@review)
    @review.create_notification_favorite(current_user)
  end

  def destroy
    current_user.unfavor(@review)
  end

  private
  def set_review
    @review = Review.find(params[:review_id])
  end
end
