class Tweet < ApplicationRecord
  has_many :comments
  has_many :tweet_imgs
  belongs_to :user
end
