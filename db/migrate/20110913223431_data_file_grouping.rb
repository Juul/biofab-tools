class DataFileGrouping < ActiveRecord::Migration
  def up
    add_column :data_files, :data_file_set_id, :integer
  end

  def down
    remove_column :data_files, :data_file_set_id
  end
end
