# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Users_count = 10
Private_posts = 2
Public_posts = 2

Emails = ['a@a.com', 'b@b.com', 'c@c.com', 'd@d.com', 'e@e.com', 'f@f.com', 'g@g.com',
          'h@h.com', 'i@i.com', 'j@j.com', 'k@k.com', 'l@l.com', 'm@m.com', 'n@n.com',
          'o@o.com', 'p@p.com', 'q@q.com', 'r@r.com', 's@s.com', 't@t.com', 'u@u.com',
          'v@v.com', 'w@w.com', 'x@x.com', 'y@y.com', 'z@z.com']

def create_users(users_count)
  (0..users_count).each do |i|
    @first_name = Faker::Name.unique.first_name
    @last_name = Faker::Name.unique.last_name
    @email = Emails[i]
    @birthdate = Faker::Date.backward(3560)
    @password = '12345678'
    @gender = 'male'

    User.create(first_name: @first_name,
                last_name: @last_name,
                email: @email,
                password: @password,
                password_confirmation: @password,
                birthdate: @birthdate,
                gender: @gender)
  end
end

def create_posts(users_count, private_posts, public_posts)
  (1..users_count).each do |i|
    @user = User.find(i)

    private_posts.times do
      @caption  = Faker::LeagueOfLegends.quote
      @is_public = false

      @user.posts.create(caption: @caption, is_public: @is_public)
    end

    public_posts.times do
      @caption = Faker::VForVendetta.quote
      @is_public = true
      @user.posts.create(caption: @caption, is_public: @is_public);
    end
  end
end

def create_friendships
  Friendship.create(user_id: 1, friend_id: 2)
  Friendship.create(user_id: 1, friend_id: 3)
  Friendship.create(user_id: 1, friend_id: 4)
  Friendship.create(user_id: 1, friend_id: 5)
  Friendship.create(user_id: 1, friend_id: 6)
  Friendship.create(user_id: 1, friend_id: 7)
  Friendship.create(user_id: 1, friend_id: 8)
  Friendship.create(user_id: 2, friend_id: 5)
  Friendship.create(user_id: 3, friend_id: 5)
  Friendship.create(user_id: 4, friend_id: 5)
  Friendship.create(user_id: 5, friend_id: 6)
  Friendship.create(user_id: 6, friend_id: 7)
  Friendship.create(user_id: 7, friend_id: 8)
  Friendship.create(user_id: 8, friend_id: 9)
  Friendship.create(user_id: 9, friend_id: 10)
end

def create_friend_request
  FriendRequest.create(requester_user_id: 1, asked_user_id: 9);
  FriendRequest.create(requester_user_id: 10, asked_user_id: 1);
  FriendRequest.create(requester_user_id: 2, asked_user_id: 10);
  FriendRequest.create(requester_user_id: 3, asked_user_id: 10);
  FriendRequest.create(requester_user_id: 4, asked_user_id: 10);
  FriendRequest.create(requester_user_id: 6, asked_user_id: 10);
  FriendRequest.create(requester_user_id: 7, asked_user_id: 10);
  FriendRequest.create(requester_user_id: 8, asked_user_id: 10);
end

def add_phone_to_users(users_count)
  (1..users_count).each do |i|
    @user = User.find(i)

    3.times do
      @user.phones.create(number: Faker::PhoneNumber.phone_number)
    end
  end
end

create_users(Users_count)
create_posts(Users_count, Private_posts, Public_posts)
create_friendships
create_friend_request
add_phone_to_users(Users_count)
