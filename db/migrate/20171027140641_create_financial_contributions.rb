class CreateFinancialContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :financial_contributions do |t|
      t.float :value, null: false
      t.references :destination, foreign_key: { to_table: :accounts }, null: false
      t.string :code, index: { unique: true }, null: false

      t.timestamps
    end
  end
end
