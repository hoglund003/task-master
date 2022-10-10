class CreateChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :changes do |t|
      t.integer :task_record_id
      t.string :action

      t.timestamps
    end
  end
end
