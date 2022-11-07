module UsersHelper
  def user_of_the_month(users)
    users = User.all

    today = Date.today
    start_date = Date.new(today.year, today.prev_month.mon)
    end_date = Date.new(today.year, today.mon)

    users.sort_by{|user| -user.points_at(start_date, end_date)}.first
  end
end
