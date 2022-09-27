task_names = ["Søppel", "Vanne", "Handling", "Støvsuger", "Oppvask", "Dekke bord"]

User.delete_all
Task.delete_all
TaskRecord.delete_all

10.times do
  User.create(name: "Ola Halvorsen")
end

task_names.each do |task_name|
  Task.create(name: task_name, points: rand(1..10))
end

User.all.each do |user|
  TaskRecord.create(user_id: user.id, task_id: Task.pluck(:id).sample, done_at: Time.now)
end