class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy :review_correct_user]
  before_action :require_login, only: %i[new edit create update destroy]

  def index
    @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.build(review_params)
    if @review.save
      redirect_to review_url
    else
      render :new
    end
  end

  def edit; end

  def update
    @review.update(review_params)
    redirect_to review_url
  end
  def destroy
    @review.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def review_params
    params.require(:reveiw).permit(:content)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_correct_user
    root_url unless @review.user == current_user
  end
end