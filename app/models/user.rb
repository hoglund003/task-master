class User < ApplicationRecord
  validates :name, presence: true, length: {minimum:2, maximum:30}
  has_many :task_records

  def points
    task_records.sum {|record| record.points}
  end

  def initials
    name.split.map{|s| s[0]}.join
  end

  def place
    # Returns User's place on scoreboard
    User.all.sort_by{|user| -user.points}.index(self) + 1
  end
end
