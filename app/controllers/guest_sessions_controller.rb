# frozen_string_literal: true

class GuestSessionsController < ApplicationController
  def create
    guest_user = User.find_or_create_by(email: "guest@exapmle.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
    session[:user_id] = guest_user.id
    flash[:success] = "ゲストユーザーとしてログインしました"
    redirect_to root_url
  end
end
