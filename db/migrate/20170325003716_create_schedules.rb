class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.timestamp :time
      t.references :room, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
