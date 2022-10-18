class CreateSlackAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :slack_accounts do |t|
      t.text :slack_id
      t.integer :user_id

      t.timestamps
    end
  end
end
