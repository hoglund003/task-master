class TaskRecord < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def points
    Task.find(task_id).points.to_i
  end

  def name
    Task.find(task_id).name
  end
end
