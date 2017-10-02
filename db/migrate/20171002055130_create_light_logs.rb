class CreateLightLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :light_logs do |t|
      t.boolean :event
      t.references :light, foreign_key: true

      t.timestamps
    end
  end
end
