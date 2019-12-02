class CreateChangePasswords < ActiveRecord::Migration[6.0]
  def change
    create_table :change_passwords do |t|
      t.integer :user_id
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end
