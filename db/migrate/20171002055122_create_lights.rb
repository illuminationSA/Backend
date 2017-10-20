class CreateLights < ActiveRecord::Migration[5.1]
  def change
    create_table :lights do |t|
      t.string :name
      t.float :consumption, :default => 0.0
      t.boolean :status, :default => false
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
