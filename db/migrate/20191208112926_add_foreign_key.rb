class AddForeignKey < ActiveRecord::Migration[6.0]
  def change
    add_reference :tweets, :user
    add_foreign_key :tweets, :users, on_delete: :cascade
  end
end
