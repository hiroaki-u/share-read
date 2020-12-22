module UsersHelper
  def user_age
    if @user.birthday
      user_birthday = @user.birthday.strftime("%Y%m%d").to_i 
      today = Date.today.strftime("%Y%m%d").to_i
      @age ||= (today-user_birthday)/10000.round
    else
      @age = "未入力"
    end
  end
end
