class CreateTaskRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :task_records do |t|
      t.integer :user_id
      t.integer :task_id
      t.datetime :done_at, :default => Time.now
      
      t.timestamps
    end
  end
end
