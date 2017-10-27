class CreateCorporateEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :corporate_entities do |t|
      t.string :cnpj
      t.string :business
      t.string :trading_name

      t.timestamps
    end
  end
end
