class CreateJwtExtendeds < ActiveRecord::Migration[6.0]
  def change
    create_table :jwt_extendeds do |t|
      t.timestamps
    end
  end
end
