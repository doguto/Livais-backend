require "faker"

NUM_USERS = 10
NUM_POSTS = 50
NUM_FOLLOWS = 30
NUM_LIKES = 150
NUM_REPOSTS = 120

puts "Seeding users..."
users = NUM_USERS.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
    image: Faker::Avatar.image # ここで画像を追加
  )
end

puts "Seeding profiles..."
users.each do |user|
  user.create_profile!(
    bio: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

puts "Seeding follow relationships..."
follow_set = Set.new

while follow_set.size < NUM_FOLLOWS
  follower = users.sample
  followed = users.sample

  next if follower == followed || follow_set.include?([follower.id, followed.id])

  follower.following << followed
  follow_set << [follower.id, followed.id]
end

puts "Seeding posts..."
posts = []

NUM_POSTS.times do
  user = users.sample
  if posts.any? && rand < 0.3
    parent_post = posts.sample
    post = user.posts.create!(
      content: "Reply: " + Faker::Lorem.sentence(word_count: rand(5..15)),
      status: "published",
      reply_to_id: parent_post.id,
      created_at: Faker::Time.backward(days: 30),
      updated_at: Time.current
    )
  else
    post = user.posts.create!(
      content: Faker::Lorem.sentence(word_count: rand(5..15)),
      status: "published",
      created_at: Faker::Time.backward(days: 30),
      updated_at: Time.current
    )
  end

  posts << post
end

puts "Seeding likes..."
users.each do |user|
  3.times do
    post = Post.order("RANDOM()").first
    Like.find_or_create_by(user: user, post: post)
  end
end

puts "Seeding reposts..."
repost_set = Set.new
max_attempts = NUM_REPOSTS * 10 
attempts = 0

while repost_set.size < NUM_REPOSTS && attempts < max_attempts
  user = User.order("RANDOM()").first
  post = Post.order("RANDOM()").first
  attempts += 1

  next if repost_set.include?([user.id, post.id]) || Repost.exists?(user: user, post: post)

  Repost.create!(user: user, post: post)
  repost_set << [user.id, post.id]
end

count = 1
10.times do
  Notice.create!(
    user_id: 91,
    notifiable_type: "Follow",
    notifiable_id: count
  )
  count += 1  
end


puts "✅ Done!"
