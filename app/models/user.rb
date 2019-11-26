class User < ApplicationRecord
  has_many :tweets
  has_many :comments
  has_many :follows
end
