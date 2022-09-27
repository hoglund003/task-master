class User < ApplicationRecord
  validates :name, presence: true, length: {minimum:2, maximum:30}
  has_many :task_records

  def points
    task_records.sum {|record| record.points}
  end
end
