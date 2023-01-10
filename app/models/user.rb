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

  def points_last_month
    today = Date.today
    start_date = Date.new(today.prev_month.year, today.prev_month.mon)
    end_date = Date.new(today.year, today.month, 1)
    points_at(start_date, end_date)
  end

  def points_this_month
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    points_at(start_date, end_date)
  end

  def points_last_week
    today = Date.today
    monday_last_week = today.prev_week
    sunday_last_week = monday_last_week.end_of_week
    start_date = monday_last_week
    end_date = sunday_last_week
    points_at(start_date, end_date)
  end

  def points_this_week
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week
    points_at(start_date, end_date)
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

  def send_dm(text)
    slack_client = Slack::Web::Client.new
    slack_client.chat_postMessage(channel: slack_account.slack_id, text: text)
  end

  def send_block(block, text)
    slack_client = Slack::Web::Client.new
    slack_client.chat_postMessage(channel: slack_account.slack_id, blocks: block, text: text)
  end

  def assign_task(task_id)
    assignment = TaskAssignment.create(user_id: id, task_id: task_id, reply: nil)
    block = assignment.slack_block
    send_block(block, "You have thing to be done! :D")
  end
end
