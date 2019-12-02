class RemoveUserIdFromTweetImg < ActiveRecord::Migration[6.0]
  def change

    remove_column :tweet_imgs, :user_id, :string
  end
end
