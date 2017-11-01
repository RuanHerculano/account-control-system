class CreateCorporateEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :corporate_entities do |t|
      t.string :cnpj, index: { unique: true }, null: false
      t.string :business, null: false
      t.string :trading_name, null: false

      t.timestamps
    end
  end
end
