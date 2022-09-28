class UsersController < ApplicationController
  def index
    @users = User.all.sort_by{|user| -user.points} 
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
