class ApplicationController < ActionController::Base
  include SessionsHelper

  def counts(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_url
    end
  end

end
