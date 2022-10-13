class Task < ApplicationRecord
  validates :name, :uniqueness => true
  validates :points, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 10}
  has_many :task_records

  def done?(selected_date=Date.today.to_s)
    selected_date = selected_date.to_date
    # Is the task done today?
    TaskRecord.where(task_id: self.id, done_at: selected_date).any?
  end

  def users(selected_date=Date.today.to_s)
    selected_date = selected_date.to_date
    # Returns the 4 Users who last did the task today
    task_records = TaskRecord.where(task_id: self.id, done_at: selected_date)
    User.where(id: task_records.map{|task_record|task_record.user_id}).last(4)
  end
end
