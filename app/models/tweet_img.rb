class TweetImg < ApplicationRecord
  belongs_to :tweet, dependent: :destroy

  mount_uploader :source, ImageUploader
end
