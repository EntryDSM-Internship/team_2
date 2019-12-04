class AddProfileImgIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :tweet_img, null: false, foreign_key: true
  end
end
