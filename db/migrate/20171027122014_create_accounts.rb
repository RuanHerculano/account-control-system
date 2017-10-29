class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.references :corporate_entity, foreign_key: { on_delete: :cascade }
      t.references :individual_entity, foreign_key: { on_delete: :cascade }
      t.references :account, foreign_key: { on_delete: :cascade }
      t.integer :level, default: 0, null: false
      t.integer :status, null: false, default: 'active'

      t.timestamps
    end
  end
end
