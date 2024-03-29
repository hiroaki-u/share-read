# frozen_string_literal: true

module UsersHelper
  def user_age
    if @user.birthday
      user_birthday = @user.birthday.strftime("%Y%m%d").to_i
      today = Date.today.strftime("%Y%m%d").to_i
      @age ||= (today - user_birthday) / 10_000.round
    else
      @age = "-"
    end
  end
end
