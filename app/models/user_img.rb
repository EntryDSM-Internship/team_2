class UserImg < ApplicationRecord
  belongs_to :user

  mount_uploader :source, ImageUploader
end
