class TaskRecordsController < ApplicationController
  def index
    @task_records = TaskRecord.all
  end

  def new
    @task_record = TaskRecord.new
    @users = User.all.map{|user| [user.name, user.id]}
    @tasks = Task.all.map{|task| [task.name, task.id, task.done?]}
  end

  def create
    @task_record = TaskRecord.new(user_id: params[:user], task_id: params[:task])

    if @task_record.save
      flash[:notice] = "The task was saved!"
      redirect_to root_path
    else
      flash.now[:alert] = "The task was not saved!"
      render "new"
    end
  end
end
