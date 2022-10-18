slack_client = Slack::Web::Client.new
users = slack_client.conversations_members(channel: '#generelt-base64')[:members]

task_names = ["Trash", "Watering", "Shopping", "Vacuum", "Dishes", "Set table", "Clean table"]

User.delete_all
SlackAccount.delete_all
Task.delete_all
TaskRecord.delete_all
Change.delete_all

users.each do |id|
  user = slack_client.users_info(user: id)[:user]
  user_record = User.create(name: user[:real_name].split(" ")[0])
  SlackAccount.create(slack_id: id, user_id: user_record.id)
end

task_names.each do |task_name|
  Task.create(name: task_name, points: rand(1..10))
end

User.all.each do |user|
  rand(15..60).times do 
    TaskRecord.create(user_id: user.id, task_id: Task.pluck(:id).sample, done_at: rand((Date.today - 200.days)..(Date.today - 1.day)))
  end
end