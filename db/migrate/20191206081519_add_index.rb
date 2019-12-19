class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :follows, :following_id
    add_index :follows, :follower_id
    add_index :follows, %i[follower_id following_id], unique: true
  end
end
