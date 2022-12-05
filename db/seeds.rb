slack_client = Slack::Web::Client.new
users = slack_client.conversations_members(channel: '#generelt-base64')[:members]

task_names = ["Trash", "Watering", "Shopping", "Vacuum", "Dishes", "Set table", "Clean table", "Press coffee"]
instructions = {
  "Trash" => "Waste: Tie the trash bag and trowe it in the dumpster outside. 
              Paper/cardboard: Take the trash downstairs to the trashcompactor.", 
  "Watering" => "Fill a watering can and water every plant in the office.", 
  "Shopping" => "Notify everyone @here in #generelt-base64: e.g.  'Shopping!'. 
                Go to the store and buy whatever food we need + requests on slack. 
                If you are paying: 
                Keep the receipt and add it in to Tripletex.", 
  "Vacuum" => "Clear out the dust compartment in the robot vacuum.", 
  "Dishes" => "When the dishwasher is finished, 
                put plates, cups etc. into the cabnets and drawers.", 
  "Set table" => "Count everyone in the office. Set the table with plates, 
                  knifes, glasses and food. 
                  Notify everyone @here in #generelt-base64: 
                  .e.g  'Lunch!', and/or in Sonofy.", 
  "Clean table" => "Use a wet cloth to clean the table surface.", 
  "Press coffee" => "Make coffee with the press jug."
}
assignment_replies = ["accepted", "denied"]

User.delete_all
SlackAccount.delete_all
Task.delete_all
TaskRecord.delete_all
TaskAssignment.delete_all
Change.delete_all
Instruction.delete_all

users.each do |id|
  user = slack_client.users_info(user: id)[:user]
  user_record = User.create(name: user[:real_name].split(" ")[0])
  SlackAccount.create(slack_id: id, user_id: user_record.id)
end

task_names.each do |task_name|
  task = Task.create(name: task_name, points: rand(1..10))
  task.build_instruction(body: instructions[task.name]).save
end

User.all.each do |user|
  rand(15..60).times do 
    TaskRecord.create(user_id: user.id, task_id: Task.pluck(:id).sample, done_at: rand((Date.today - 200.days)..(Date.today - 1.day)))
  end
end

10.times do 
  TaskAssignment.create!(user_id: User.pluck(:id).sample, task_id: Task.pluck(:id).sample, reply: assignment_replies.sample, date: rand((Date.today - 200.days)..(Date.today - 1.day)))
end