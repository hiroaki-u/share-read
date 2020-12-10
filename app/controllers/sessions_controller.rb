class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログインしました"
      redirect_to root_url
    else
      flash.now[:danger] = "ログインできませんでした"
      render :new
    end
  end

  def destroy
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:id] = @user.id
      return true
    else
      return false
    end
  end
end
