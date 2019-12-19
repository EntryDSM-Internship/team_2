class AddFollowingIdToFollow < ActiveRecord::Migration[6.0]
  def change
    add_column :follows, :following_id, :integer
    add_column :follows, :follower_id, :integer
  end
end
