class TaskRecordsController < ApplicationController
  def index
    @task_records = TaskRecord.all
  end

  def new
    @task_record = TaskRecord.new
    @users = User.all.map{|user| [user.name, user.id]}
    @tasks = Task.all
  end

  def create
    @task_record = TaskRecord.new(user_id: params[:user], task_id: params[:task], done_at: Time.now)

    if @task_record.save
      flash[:notice] = "The task was saved!"
      redirect_to root_path
    else
      flash.now[:alert] = "The task was not saved!"
      @users = User.all.map{|user| [user.name, user.id]}
      @tasks = Task.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task_record = TaskRecord.find(params[:id])
  end
end
