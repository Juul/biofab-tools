class CreateDataFiles < ActiveRecord::Migration
  def change
    create_table :data_files do |t|

      t.string :content_type
      t.string :filepath

      t.timestamps
    end
  end
end
