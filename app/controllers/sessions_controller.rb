# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

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
    session[:user_id] = nil
    redirect_to root_url
    flash[:success] = "ログアウトしました"
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    return false unless @user&.authenticate(password)

    session[:user_id] = @user.id
  end
end
