Subscriber.subscribe('visite') do |event|
  puts "transaction_id: #{event.transaction_id}, name: #{event.name}, time: #{event.time}, end_time: #{event.end}, duration: #{event.duration}, user_id: #{event.payload[:user].id}"
end
