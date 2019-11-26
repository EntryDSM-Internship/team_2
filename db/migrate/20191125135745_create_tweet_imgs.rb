class CreateTweetImgs < ActiveRecord::Migration[6.0]
  def change
    create_table :tweet_imgs do |t|
      t.references :tweet, null: false, foreign_key: true
      t.string :source, null: false
      t.boolean :if_profile, default: false

      t.timestamps
    end
  end
end
