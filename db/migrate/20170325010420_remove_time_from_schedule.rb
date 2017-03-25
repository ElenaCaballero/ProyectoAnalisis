class RemoveTimeFromSchedule < ActiveRecord::Migration[5.0]
  def change
    remove_column :schedules, :time, :timestamp
  end
end
