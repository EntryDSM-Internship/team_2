class UserImg < ApplicationRecord
  belongs_to :user

  mount_uploader :source, ImageUploader
  validates file_size: { maximum: 50.megabytes.to_i }
end
