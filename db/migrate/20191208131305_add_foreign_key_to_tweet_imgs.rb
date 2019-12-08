class AddForeignKeyToTweetImgs < ActiveRecord::Migration[6.0]
  def change
    add_reference :tweet_imgs, :tweet
    add_foreign_key :tweet_imgs, :tweets, on_delete: :cascade
  end
end
