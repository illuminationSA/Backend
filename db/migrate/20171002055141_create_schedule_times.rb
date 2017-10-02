class CreateScheduleTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :schedule_times do |t|
      t.boolean :set_to
      t.timestamp :event_time
      t.references :light, foreign_key: true

      t.timestamps
    end
  end
end
