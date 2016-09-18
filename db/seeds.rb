# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..3 do
  User.create([email: "user#{i}@gmail.com", password: "111111", password_confirmation: "111111"])
end

puts "3 Users' accounts created."

Team.Create([name: "Tower 测试", user_id: 1])

Event.Create([ownerable_id: 1, ownerable_type:"Team", creator_id: 1, action:"create_team", eventable_type: "Team", eventable_id: 1])

puts "1 Team created."



Project.Create([name: "tower-todo-index-1", team_id: 1])

Event.Create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"create_project", eventable_id: 1, eventable_type: "Project"])

puts "1 Project created."

Todo.Create([title: "实现新增用户", todoable_id: 1, todoable_type: "Project"])

Event.Create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"create_todo", eventable_id: 1, eventable_type: "Todo"])

Todo.Create([title: "实现短信发送", todoable_id: 1, todoable_type: "Project"])
Assignment.Create([todo_id: 2, origin_executor_id: 2, origin_deadline: "2016-09-25"])

Event.Create([ownerable_id: 1, ownerable_type:"Project", creator_id: 1, action:"create_todo", eventable_id: 2, eventable_type: "Todo"])
