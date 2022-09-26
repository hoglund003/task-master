class TaskRecordsController < ApplicationController
  def new
    @users = User.all.map{|user| [user.name, user.id]}
    @tasks = Task.all.map{|task| [task.name, task.id]}
  end
end
