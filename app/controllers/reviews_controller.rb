class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_review, only: %i[show update destroy review_correct_user]
  before_action :set_book, only: %i[show create update destroy]
  before_action :review_correct_user, only: %i[update destroy]
  before_action :confirm_draft, only: %i[show update destroy]

  def index
    @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @comments = @review.comments.order(id: :desc)
    @comment = Comment.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to book_review_path(@book, @review)
    else
      flash[:success] = "投稿できませんでした"
      redirect_to book_url(@book)
    end
  end

  def update
    unless @review.update(review_params)
      flash[:success] = "投稿できませんでした"
    end
    redirect_to book_review_path(@book, @review)
  end

  def destroy
    @review.destroy
    redirect_to root_url
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