class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.references :corporate_entity, foreign_key: true
      t.references :individual_entity, foreign_key: true
      t.references :account, foreign_key: true
      t.integer :level
      t.integer :status

      t.timestamps
    end
    add_index :accounts, :status
  end
end
