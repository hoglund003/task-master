class Task < ApplicationRecord
  validates :name, :uniqueness => true
  validates :points, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 10}
  has_many :task_records

  def done?
    # Is the task done today?
    TaskRecord.where(task_id: self.id, done_at: (Time.now.midnight)..(Time.now.midnight + 1.day)).any?
  end

  def users
    # Returns the 4 Users who last did the task today
    task_records = TaskRecord.where(task_id: self.id, done_at: (Time.now.midnight)..(Time.now.midnight + 1.day))
    User.where(id: task_records.map{|task_record|task_record.user_id}).last(4)
  end
end
