class CreateExpressionLevels < ActiveRecord::Migration
  def change
    create_table :expression_levels do |t|

      t.integer :promoter_part_id
      t.integer :fiveprime_part_id
      t.string :plate
      t.string :well
      t.float :average
      t.float :standard_deviation

      t.timestamps
    end
  end
end
