class CreateLights < ActiveRecord::Migration[5.0]
  def change
    create_table :lights do |t|
      t.string :name
      t.float :consumption
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
