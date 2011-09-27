class ExpressionLevelAddNormalizedExp < ActiveRecord::Migration
  def up
    add_column :expression_levels, :normalized, :float
  end

  def down
  end
end
