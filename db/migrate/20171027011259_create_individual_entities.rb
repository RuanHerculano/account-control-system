class CreateIndividualEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_entities do |t|
      t.string :cpf,       null: false
      t.string :full_name, null: false
      t.date :date_birth,  null: false

      t.timestamps
    end
  end
end
