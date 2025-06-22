Repost.destroy_all
Like.destroy_all
Reply.destroy_all
Quote.destroy_all
Post.destroy_all
Follow.destroy_all
Profile.destroy_all
User.destroy_all

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
  follower = User.all.sample
  followed = User.all.sample

  next if follower == followed || follow_set.include?([follower.id, followed.id])

  follower.following << followed
  follow_set << [follower.id, followed.id]
end

puts "Seeding posts..."
posts = []

NUM_POSTS.times do
  user = users.sample
  post_attributes = {
    user: user,
    status: "published",
    created_at: Faker::Time.backward(days: 30)
  }

  roll = rand

  if posts.any? && roll < 0.2
    quoted_post = posts.sample
    post_attributes[:content] = "This is a quote: " + Faker::Lorem.sentence(word_count: rand(5..15))

  elsif posts.any? && roll < 0.5
    parent_post = posts.sample
    post_attributes[:content] = "Replying to this: " + Faker::Lorem.sentence(word_count: rand(5..15))
    post_attributes[:reply_to_id] = parent_post.id

  else
    post_attributes[:content] = Faker::Lorem.sentence(word_count: rand(10..20))
  end

  new_post = Post.create!(post_attributes)

  if posts.any? && roll < 0.2
    Quote.create!(quoted_post: quoted_post, quoting_post: new_post)
  elsif posts.any? && roll < 0.5
    Reply.create!(parent_post: parent_post, child_post: new_post)
  end

  posts << new_post
end

puts "Seeding likes..."
users.each do |user|
  3.times do
    post = posts.sample
    Like.find_or_create_by(user: user, post: post)
  end
end

puts "Seeding reposts..."
repost_set = Set.new
max_attempts = NUM_REPOSTS * 10
attempts = 0

while repost_set.size < NUM_REPOSTS && attempts < max_attempts
  user = users.sample
  post = posts.sample
  attempts += 1

  next if repost_set.include?([user.id, post.id]) || Repost.exists?(user: user, post: post)

  Repost.create!(user: user, post: post)
  repost_set << [user.id, post.id]
end

100.times do
  user = User.all.sample
  follows = Follow.where(followed_id: user.id)
  next unless follows

  follows.each do |follow|
    next if Notice.exists?(user: user, notifiable: follow)

    puts "Creating notice for user #{user.id} and follow #{follow.id}"
    Notice.create!(
      user: user,
      notifiable: follow,
      created_at: Faker::Time.backward(days: 30),
      updated_at: Time.current
    )
  end
end

puts "✅ Done!"
