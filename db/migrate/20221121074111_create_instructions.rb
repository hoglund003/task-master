class CreateInstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :instructions do |t|
      t.integer :task_id
      t.text :body

      t.timestamps
    end
  end
end
