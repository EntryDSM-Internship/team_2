class AddAcceptedToFollow < ActiveRecord::Migration[6.0]
  def change
    add_column :follows, :accepted, :integer, default: 0
  end
end
