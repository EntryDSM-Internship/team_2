class FixUserImgIdDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :tweet_img_id, 1
  end
end
