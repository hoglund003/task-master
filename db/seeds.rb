user_names = Array((1..5).map{|n| Faker::Name.name})
task_names = ["Søppel", "Vanne", "Handling", "Støvsuger", "Oppvask", "Dekke bord", "Vaske bord"]

User.delete_all
Task.delete_all
TaskRecord.delete_all
Change.delete_all

user_names.each do |user_name|
  User.create(name: user_name)
end

task_names.each do |task_name|
  Task.create(name: task_name, points: rand(1..10))
end

User.all.each do |user|
  rand(15..60).times do 
    TaskRecord.create(user_id: user.id, task_id: Task.pluck(:id).sample, done_at: rand((Date.today - 200.days)..(Date.today - 1.day)))
  end
end