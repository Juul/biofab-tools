class CreateDataFileSets < ActiveRecord::Migration
  def change
    create_table :data_file_sets do |t|

      t.timestamps
    end
  end
end
