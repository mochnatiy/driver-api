require 'mongoid'
require './models/user'
require './models/task'

Mongoid.load!('./database.yml', :development)

users = [
  { token: 'e7dbeb877a9755ef64ae0eb70cab7ea7', access_level: 'driver' },
  { token: '676c40531bd25ec2c0af459f40b91b5a', access_level: 'driver' },
  { token: '22b39afe74ec08301937b2e181f4cab9', access_level: 'driver' },
  { token: '1744b5820f984cd2841fe2e0e52bd20a', access_level: 'manager' },
  { token: 'c1b643f56d14d5943861d6042567c278', access_level: 'manager' },
]

users.each do |user|
  User.create!(token: user[:token], access_level: user[:access_level])
end

tasks = [
  { number: 1, status: 'New', pickup: [58, 17], delivery: [91, 28] },
  { number: 2, status: 'New', pickup: [64, 20], delivery: [100, 17] },
  { number: 3, status: 'New', pickup: [71, 31], delivery: [55, 32] },
  { number: 4, status: 'New', pickup: [80, 40], delivery: [114, 5] },
  { number: 5, status: 'New', pickup: [81, 37], delivery: [93, 30] }
]

tasks.each do |task|
  Task.create!(
    number: task[:number],
    status: task[:status],
    pickup: task[:pickup],
    delivery: task[:delivery]
  )
end