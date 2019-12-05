class RemoveLikeFromTweet < ActiveRecord::Migration[6.0]
  def change
    remove_column :tweets, :like, :integer
  end
end
