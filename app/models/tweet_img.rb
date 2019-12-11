class TweetImg < ApplicationRecord
  belongs_to :tweet

  mount_uploader :source, ImageUploader
end
