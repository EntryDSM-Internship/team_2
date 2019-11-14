class CreateTemps < ActiveRecord::Migration[6.0]
  def change
    create_table :temps do |t|

      t.timestamps
    end
  end
end
