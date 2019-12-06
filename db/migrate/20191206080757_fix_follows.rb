class FixFollows < ActiveRecord::Migration[6.0]
  def change
    remove_reference :follows, :follower
    remove_reference :follows, :following
  end
end
