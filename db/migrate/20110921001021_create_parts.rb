class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :part_type_id
      t.string :name
      t.string :description
      t.string :sequence
      t.string :col

      t.timestamps
    end
  end
end
