class TaskRecordsController < ApplicationController
  def index
    @task_records = TaskRecord.all.order(done_at: :desc)
  end

  def new
    @task_record = TaskRecord.new
    @users = User.all.map{|user| [user.name, user.id]}
    @tasks = Task.all
    @selected_date = params[:date] || Date.today

    if turbo_frame_request?
      render partial: "board", :locals => { tasks: @tasks, users: @users, selected_date: @selected_date }
      return
    end
  end

  def create
    @task_record = TaskRecord.new(user_id: params[:user], task_id: params[:task], done_at: params[:selected_date])
    
    if @task_record.save
      @users = User.all.map{|user| [user.name, user.id]}
      @tasks = Task.all
      flash[:notice] = "The task was saved!"
      render partial: "board", :locals => { tasks: @tasks, users: @users, selected_date: params[:selected_date], }
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
