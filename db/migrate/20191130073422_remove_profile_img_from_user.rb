class RemoveProfileImgFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :profile_img, :string
  end
end
