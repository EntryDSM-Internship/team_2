class AddSendedAtToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sended_at, :timestamp
  end
end
