class CreateUserImgs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_imgs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :source, null: false

      t.timestamps
    end
  end
end
