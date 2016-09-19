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

Team.create([name: "Tower 测试", user_id: 1])

Event.create([ownerable_id: 1, ownerable_type:"Team", creator_id: 1, action:"create_team", eventable_type: "Team", eventable_id: 1])

puts "1 Team created."



Project.create([name: "tower-todo-index-1", team_id: 1])

Event.create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"create_project", eventable_id: 1, eventable_type: "Project"])

puts "1 Project created."

Todo.create([title: "实现新增用户", todoable_id: 1, todoable_type: "Project"])

Event.create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"create_todo_with_executor", eventable_id: 1, eventable_type: "Todo"])
Assignment.create([todo_id: 1, origin_executor_id: 1, origin_deadline: "2016-09-25"])


Todo.create([title: "实现短信发送", todoable_id: 1, todoable_type: "Project"])
Assignment.create([todo_id: 2, origin_executor_id: 1, origin_deadline: "2016-09-25", new_executor_id: 2])

Event.create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"assign_executor_todo", eventable_id: 2, eventable_type: "Todo"])

Todo.create([title: "实现短信发送", todoable_id: 1, todoable_type: "Project"])

assignment = Assignment.find(2)
assignment.update_attributes!(new_deadline: "2017-09-27")

Event.create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"assign_deadline_todo", eventable_id: 2, eventable_type: "Todo"])
