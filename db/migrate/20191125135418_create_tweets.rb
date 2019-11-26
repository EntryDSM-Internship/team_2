class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :content, null: false
      t.integer :like, default: 0

      t.timestamps
    end
  end
end
