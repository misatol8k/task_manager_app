class AddEndDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :end_date, :date, null: false, default: -> { 'NOW()' }
  end
end
