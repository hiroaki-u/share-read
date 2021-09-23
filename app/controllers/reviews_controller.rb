# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :require_login, except: %i[show]
  before_action :set_review, only: %i[show update destroy review_correct_user]
  before_action :set_book, only: %i[show create update destroy]
  before_action :review_correct_user, only: %i[update destroy]
  before_action :confirm_draft, only: %i[show update destroy]

  def index
    @reviews = Review.where(status: 1).includes(:book, :user).order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @comments = @review.comments.includes(:book, :user).order(id: :desc)
    @comment = Comment.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    draft_judge
    if @review.save
      @review.save
      flash[:success] = "投稿しました"
      redirect_to book_review_path(@book, @review)
    else
      flash[:danger] = "レビューが空欄です。投稿できませんでした。"
      redirect_to book_url(@book)
    end
  end

  def update
    draft_judge
    if @review.update(review_params)
      flash[:success] = "投稿しました"
    else
      flash[:danger] = "レビューが空欄です。投稿できませんでした"
    end
    redirect_to book_review_path(@book, @review)
  end

  def destroy
    @review.destroy
    flash[:success] = "投稿を削除しました"
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
    redirect_to root_path if @review.draft? && @review.user.id != current_user.id
  end

  def draft_judge
    case params[:commit]
    when "公開する"
      @review.status = "published"
    when "下書きする"
      @review.status = "draft"
    end
  end
end
