class User < ApplicationRecord
  has_many :tweets
  has_many :comments
  has_many :follower_relations, foreign_key: 'following_id', class_name: 'Follow'
  has_many :followers, through: :follower_relations, source: :follower

  has_many :following_relations, foreign_key: 'follower_id', class_name: 'Follow'
  has_many :followings, through: :following_relations, source: :following

  has_secure_password
end
