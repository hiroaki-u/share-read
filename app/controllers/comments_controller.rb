class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_comment, only: %i[update edit destroy comment_correct_user]
  before_action :set_review
  before_action :set_comments, only: %i[create edit destroy]
  before_action :comment_correct_user, only: %i[update edit destory]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @review.create_notification_comment(current_user, @comment.id)
    else
      render "post/show"
      flash[:alert] = "コメントを(140文字以内で)入力してください"
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to book_review_path(@review.book, @review)
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "コメントを(140文字以内で)入力してください"
    end
  end

  def edit
    @book = @review.book
    render "reviews/show"
  end

  def destroy
    @comment.destroy
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  def set_comments
    @comments = @review.comments.order(id: :desc)
  end

  def comment_params
    params.require(:comment).permit(:content, :review_id)
  end

  def comment_correct_user
    redirect_to root_url unless @comment.user_id == current_user.id
  end
end
