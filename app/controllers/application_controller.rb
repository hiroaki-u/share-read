# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  def counts(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end

  private

  def require_login
    redirect_to login_url unless logged_in?
  end
end
