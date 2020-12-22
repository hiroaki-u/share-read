class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_review

  def create
    current_user.favor(@review)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfavor(@review)
    redirect_back(fallback_location: root_path)
  end

  private
  def set_review
    @review = Review.find(params[:review_id])
  end
end
