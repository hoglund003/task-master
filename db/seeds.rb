user_names = ["Ola Halvorsen", "Joe Doe", "Ada Lovelace", "Navn Navnesen"]
task_names = ["Søppel", "Vanne", "Handling", "Støvsuger", "Oppvask", "Dekke bord", "Vaske bord"]

User.delete_all
Task.delete_all
TaskRecord.delete_all

user_names.each do |user_name|
  User.create(name: user_name)
end

task_names.each do |task_name|
  Task.create(name: task_name, points: rand(1..10))
end

User.all.each do |user|
  rand(5..50).times do 
    TaskRecord.create(user_id: user.id, task_id: Task.pluck(:id).sample, done_at: rand((Time.now - 50.days)..(Time.now - 1.day)))
  end
end