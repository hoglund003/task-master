class User < ApplicationRecord
  validates :name, presence: true, length: {minimum:2, maximum:30}
  has_many :task_records
  has_one :slack_account

  def points
    task_records.sum {|record| record.points}
  end

  def points_at(start_date, end_date)
    # Returns the users points from a spesific date.
    task_records.where(done_at: (start_date)..(end_date)).sum {|record| record.points}
  end

  def initials
    name.split.map{|s| s[0]}.join
  end

  def place
    # Returns User's place on scoreboard
    User.all.sort_by{|user| -user.points}.index(self) + 1
  end

  def avatar_url
    "https://avatars.dicebear.com/api/initials/#{initials}.svg?radius=50"
  end
end
