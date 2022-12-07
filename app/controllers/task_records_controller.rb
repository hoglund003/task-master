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
    @users = User.all
    @tasks = Task.all
    @selected_date = params[:date] || Date.today.to_s

    if turbo_frame_request?
      render partial: "board", :locals => { tasks: @tasks, users: @users, selected_date: @selected_date }
      return
    end
  end

  def create
    @task_record = TaskRecord.new(task_record_params)

    # toggle task
    similar_record = TaskRecord.where(
      user_id: @task_record.user_id, 
      task_id: @task_record.task_id,
      created_at: (Time.now - 2.minutes)..(Time.now)
    ).first

    unless similar_record.nil?
      similar_record.destroy
      @users = User.all
      @tasks = Task.all
      flash.now[:alert] = "The task was removed!"
      render partial: "board", :locals => { tasks: @tasks, users: @users, selected_date: params[:task_record][:done_at], }
    else
      if @task_record.save
        @users = User.all
        @tasks = Task.all
        flash.now[:notice] = "The task was saved!"
        render partial: "board", :locals => { tasks: @tasks, users: @users, selected_date: params[:task_record][:done_at], }
      else
        flash[:alert] = "The task was not saved!"
        redirect_to root_path
      end
    end
  end

  def show
    @task_record = TaskRecord.find(params[:id])
    begin
      @other_records_that_day = TaskRecord.all.where(task_id: @task_record.task_id, done_at: @task_record.done_at).where.not(user_id: @task_record.user_id).group(:user_id).uniq
    rescue
      @other_records_that_day = []
    end
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

  private 

  def task_record_params
    params.require(:task_record).permit(:user_id, :task_id, :done_at)
  end
end
