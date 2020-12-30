# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login, only: %i[edit update followings followers favorites bookcases draft]
  before_action :set_user, only: %i[show edit update followings followers favorites bookcases draft self_user]
  before_action :self_user, only: %i[edit update draft]

  def show
    if current_user = @user
      @reviews = @user.feed_reviews.where(status: 1).order(updated_at: :desc).page(params[:page]).per(6)
    else
      @reviews = @user.reviews.where(status: 1).order(updated_at: :desc).page(params[:page]).per(6)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
      flash[:success] = "ユーザー登録完了しました。"
      session[:user_id] = @user.id
    else
      render :new
      flash.now[:danger] = "ユーザー登録ができませんでした。"
    end
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'プロフィールを変更しました。'
      redirect_to @user
    else
      render :edit
      flash.now[:danger] = 'プロフィーが変更できませんでした。'
    end
  end

  def followings
    @followings = @user.followings.order(id: :desc).page(params[:page]).per(9)
  end

  def followers
    @followers = @user.followers.order(id: :desc).page(params[:page]).per(9)
  end

  def favorites
    @favorites = @user.favorings.order(updated_at: :desc).page(params[:page]).per(6)
  end

  def bookcases
    @bookcases = @user.register_books.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def draft
    @draft_reviews = @user.reviews.where(status: 0).order(updated_at: :desc).page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def self_user
    redirect_to root_url unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:name, :gender, :user_image, :birthday, :introduction)
  end
end
