class RemoveUserIdIdFromTweet < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tweets, :user_id
  end
end
