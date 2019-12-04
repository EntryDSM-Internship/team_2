class RemoveTypeFromTweetImg < ActiveRecord::Migration[6.0]
  def change

    remove_column :tweet_imgs, :if_profile, :boolean
    add_reference :tweet_imgs, :user, default: 0, foreign_key: true
    change_column_default :tweet_imgs, :tweet_id, 0
  end
end
