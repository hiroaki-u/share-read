class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy :review_correct_user]
  before_action :require_login, only: %i[new edit create update destroy]

  def index
    @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @comments = @review.comments.order(id: :desc)
    @comment = Comment.new
  end

  def new
    @review = current_user.reviews.new
    @book = Book.find_by(isbn: params[:book_id])
  end

  def create
    @book = Book.find_by(isbn: params[:book_id])
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to book_review_path(@book, @review)
    else
      render :new
    end
  end

  def edit
    @book = Book.find_by(isbn: params[:book_id])
  end

  def update
    @book = Book.find_by(isbn: params[:book_id])
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
    params.require(:review).permit(:content, :book_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_correct_user
    root_url unless @review.user == current_user
  end
end