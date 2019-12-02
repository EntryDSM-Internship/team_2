class RemoveTweetImgIdFromUser < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :tweet_img_id, :string
  end
end
