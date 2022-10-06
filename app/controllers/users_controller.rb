class UsersController < ApplicationController
  def index
    @users = User.all.sort_by{|user| -user.points_at(params[:start_date], params[:end_date])}[0, 5] # Returs the 5 users with most points
    if turbo_frame_request?
      render partial: "users/scoreboard", locals: { users: @users }
      return
    end
  end

  def show
    @user = User.find(params[:id])
    # Create a hash to reprecent data by chart
    @chart_hash = {}
    Task.all.each do |task|
      @chart_hash.store(task.name, @user.task_records.where(task_id: task.id).count)
    end
  end
end
