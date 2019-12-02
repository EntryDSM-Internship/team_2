class FixColumnDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :temp_users, :verified, false
  end
end
