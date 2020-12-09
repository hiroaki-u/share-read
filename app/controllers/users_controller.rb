class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
      flash[:notice] = "ユーザー登録完了しました。"
    else
      render :new
      flash[:notice] = "ユーザー登録ができませんでした。"
    end
  end

  def edit
  end

  def update
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
