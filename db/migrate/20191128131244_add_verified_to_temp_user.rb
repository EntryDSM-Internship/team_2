class AddVerifiedToTempUser < ActiveRecord::Migration[6.0]
  def change
    add_column :temp_users, :verified, :string
  end
end
