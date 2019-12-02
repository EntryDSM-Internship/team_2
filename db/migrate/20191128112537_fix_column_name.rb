class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :temp_users, :authCode, :auth_code
  end
end
