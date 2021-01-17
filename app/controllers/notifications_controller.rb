# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :require_login

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(15)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
