class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_review, only: %i[show edit update destroy review_correct_user]
  before_action :set_book, only: %i[new create edit update destroy]
  before_action :review_correct_user, only: %i[edit update destroy]
  before_action :confirm_draft, only: %i[show edit update destroy]

  def index
    @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @comments = @review.comments.order(id: :desc)
    @comment = Comment.new
  end

  def new
    @review = current_user.reviews.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to book_review_path(@book, @review)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to book_review_path(@book, @review)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def review_params
    params.require(:review).permit(:content, :status, :book_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_book
    @book = Book.find_by(isbn: params[:book_id])
  end

  def review_correct_user
    root_url unless @review.user == current_user
  end

  def confirm_draft
    redirect_to root_path if (@review.draft? && @review.user.id != current_user.id)
  end
end