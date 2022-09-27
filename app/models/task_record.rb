class TaskRecord < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def points
    Task.find(task_id).points.to_i
  end
end
