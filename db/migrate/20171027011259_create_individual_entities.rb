class CreateIndividualEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_entities do |t|
      t.string :cpf
      t.string :full_name
      t.date :date_birth

      t.timestamps
    end
  end
end
