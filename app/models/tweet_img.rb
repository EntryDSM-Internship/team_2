class TweetImg < ApplicationRecord
  belongs_to :tweet

  mount_uploader :source, ImageUploader
  validates file_size: { maximum: 50.megabytes.to_i }
end
