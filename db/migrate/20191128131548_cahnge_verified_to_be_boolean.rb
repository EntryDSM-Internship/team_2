class CahngeVerifiedToBeBoolean < ActiveRecord::Migration[6.0]
  def change
    change_column :temp_users, :verified, :boolean
    change_column_default :temp_users, :verified, true
  end
end
