module UsersHelper
  def user_of_last_month(users)
    users = User.all

    today = Date.today
    start_date = Date.new(today.year, today.prev_month.mon)
    end_date = Date.new(today.year, today.mon)

    users.sort_by{|user| -user.points_at(start_date, end_date)}.first
  end

  def user_of_last_week(users)
    users = User.all

    today = Date.today
    monday_last_week = (today - 1.week).beginning_of_week
    sunday_last_week = (today - 1.week).end_of_week
    start_date = monday_last_week
    end_date = sunday_last_week

    users.sort_by{|user| -user.points_at(start_date, end_date)}.first
  end
end
