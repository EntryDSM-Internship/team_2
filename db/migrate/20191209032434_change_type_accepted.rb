class ChangeTypeAccepted < ActiveRecord::Migration[6.0]
  def change
    change_column :follows, :accepted, :boolean, default: false
  end
end
