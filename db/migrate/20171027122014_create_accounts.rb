class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.float :value, null: false, default: 0
      t.string :name, null: false
      t.references :corporate_entity, foreign_key: true
      t.references :individual_entity, foreign_key: true
      t.references :account, foreign_key: true
      t.integer :level, default: 0, null: false
      t.integer :status, null: false, default: 'active'

      t.timestamps
    end
  end
end
