class Tweet < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :tweet_imgs, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  belongs_to :user
end
