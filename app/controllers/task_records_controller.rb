class TaskRecordsController < ApplicationController
  def index
    unless params[:user_id].nil?
      @task_records = TaskRecord.all.where(user_id: params[:user_id]).order(done_at: :desc).page params[:page]
    else
      @task_records = TaskRecord.all.order(done_at: :desc).page params[:page]
    end
  end

  def new
    @task_record = TaskRecord.new
    @users = User.all.map{|user| [user.name, user.id]}
    @tasks = Task.all
    @selected_date = params[:date] || Date.today.to_s

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
      flash.now[:notice] = "The task was saved!"
      render partial: "board", :locals => { tasks: @tasks, users: @users, selected_date: params[:selected_date], }
    else
      flash[:alert] = "The task was not saved!"
      redirect_to root_path
    end
  end

  def show
    @task_record = TaskRecord.find(params[:id])
    @other_records_that_day = TaskRecord.all.where(task_id: @task_record.task_id, done_at: @task_record.done_at).where.not(user_id: @task_record.user_id).group(:user_id).uniq
  end

  def destroy
    @task_record = TaskRecord.find(params[:id])
    @task_record.destroy
    Change.create(task_record_id: @task_record.id, action: "delete")
    redirect_to task_records_path
  end

  def update
    Change.create(task_record_id: @task_record.id, action: "edit")
  end
end
