class AddAuthcodeToTempUser < ActiveRecord::Migration[6.0]
  def change
    add_column :temp_users, :authCode, :string
  end
end
