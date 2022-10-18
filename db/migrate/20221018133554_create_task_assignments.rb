class CreateTaskAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :task_assignments do |t|
      t.integer :user_id
      t.integer :task_id
      t.text :reply
      t.date :date

      t.timestamps
    end
  end
end
