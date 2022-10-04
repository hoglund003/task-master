class TaskRecordsController < ApplicationController
  def index
    @task_records = TaskRecord.all.order(done_at: :desc)
  end

  def new
    @task_record = TaskRecord.new
    @users = User.all.map{|user| [user.name, user.id]}
    @tasks = Task.all
    @selected_date = params[:date]
  end

  def create
    @task_record = TaskRecord.new(user_id: params[:user], task_id: params[:task], done_at: Time.now)

    if @task_record.save
      flash[:notice] = "The task was saved!"
      redirect_to root_path
    else
      flash[:alert] = "The task was not saved!"
      redirect_to root_path
    end
  end

  def show
    @task_record = TaskRecord.find(params[:id])
  end

  def destroy
    @task_record = TaskRecord.find(params[:id])
    @task_record.destroy
    redirect_to task_records_path
  end
end
