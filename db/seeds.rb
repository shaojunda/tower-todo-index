# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..3 do
  User.create([email: "user#{i}@gmail.com", password: "111111", password_confirmation: "111111", user_name: "user#{i}"])
end

puts "3 Users' accounts created."

Team.create([name: "Tower 测试", user_id: 1, created_at: "2016-09-01"])

Event.create([ownerable_id: 1, ownerable_type:"Team", creator_id: 1, action:"create_team", eventable_type: "Team", eventable_id: 1 , created_at: "2016-09-01"])

puts "1 Team created."



Project.create([name: "tower-todo-index-1", team_id: 1, created_at: "2016-09-01 10:00:00"])

Event.create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"create_project", eventable_id: 1, eventable_type: "Project", created_at: "2016-09-01 10:00:00"])

Project.create([name: "tower-todo-index-2", team_id: 1, created_at: "2016-09-01 11:00:00"])

Event.create([ownerable_id: 2, ownerable_type:"Project", creator_id: 1, action:"create_project", eventable_id: 2, eventable_type: "Project", created_at: "2016-09-01 11:00:00"])

puts "2 Project created."


require "csv"

csv_text = File.read('import/todos.csv')
csv = CSV.parse(csv_text, :headers => false)

csv.each_with_index do |row, i|
  next if i == 0

  Todo.create(

    title: row[0],
    assignment_id: row[1],
    todoable_id: row[2],
    todoable_type: row[3],
    created_at: row[4]
  )
end

puts "todos created."

csv_text = File.read('import/assignments.csv')
csv = CSV.parse(csv_text, :headers => false)

csv.each_with_index do |row, i|
  next if i == 0

  origin_deadline =
    begin
      Date.parse(row[3])
    rescue
      nil
    end
  Assignment.create(

    todo_id: row[0],
    origin_executor_id: row[1],
    origin_deadline: row[2],
    created_at: row[3]
  )
end

puts "assignments created."

csv_text = File.read('import/comments.csv')
csv = CSV.parse(csv_text, :headers => false)

csv.each_with_index do |row, i|
  next if i == 0

  Comment.create(

    todo_id: row[0],
    content: row[1],
    created_at: row[2]

  )
end

puts "comments created."

csv_text = File.read('import/events.csv')
csv = CSV.parse(csv_text, :headers => false)

csv.each_with_index do |row, i|
  next if i == 0

  Event.create(

    creator_id: row[0],
    action: row[1],
    eventable_id: row[2],
    eventable_type: row[3],
    ownerable_id: row[4],
    ownerable_type: row[5],
    created_at: row[6]

  )
end

puts "events created."


ProjectPermission.create([user_id:1, project_id:1, level:"owner"])
ProjectPermission.create([user_id:2, project_id:1, level:"member"])
ProjectPermission.create([user_id:3, project_id:1, level:"member"])
ProjectPermission.create([user_id:1, project_id:2, level:"owner"])
ProjectPermission.create([user_id:2, project_id:2, level:"member"])
ProjectPermission.create([user_id:3, project_id:2, level:"member"])
