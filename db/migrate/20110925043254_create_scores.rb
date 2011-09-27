class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :exp1_id
      t.integer :exp2_id
      t.integer :value

      t.timestamps
    end
  end
end
