# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110925055247) do

  create_table "annotated_part", :id => false, :force => true do |t|
    t.integer "id",         :null => false
    t.text    "juul_id",    :null => false
    t.integer "feature_id", :null => false
  end

  add_index "annotated_part", ["id"], :name => "annotated_part_id_key", :unique => true
  add_index "annotated_part", ["juul_id"], :name => "annotated_part_unique", :unique => true

  create_table "ape_colors", :force => true do |t|
    t.integer "feature_id",  :null => false
    t.text    "ape_color_a", :null => false
    t.text    "ape_color_b", :null => false
  end

  add_index "ape_colors", ["feature_id"], :name => "feature_id_unique", :unique => true

  create_table "chassis", :id => false, :force => true do |t|
    t.integer "id",          :null => false
    t.text    "name",        :null => false
    t.text    "description", :null => false
  end

  create_table "collection", :force => true do |t|
    t.text   "name",                          :null => false
    t.text   "juul_id",                       :null => false
    t.text   "version",                       :null => false
    t.text   "description",                   :null => false
    t.string "release_status", :limit => 30,  :null => false
    t.date   "release_date",                  :null => false
    t.string "chassis",        :limit => 100
  end

  add_index "collection", ["id"], :name => "project_id_key", :unique => true

  create_table "collection_annotated_part", :id => false, :force => true do |t|
    t.integer "id",            :null => false
    t.integer "collection_id", :null => false
    t.integer "part_id",       :null => false
  end

  add_index "collection_annotated_part", ["part_id"], :name => "part_id_unique", :unique => true

  create_table "collection_design", :force => true do |t|
    t.integer "collection_id",               :null => false
    t.string  "design_id",     :limit => 30, :null => false
  end

  create_table "cytometer_measurement", :id => false, :force => true do |t|
    t.integer "id",                :limit => 8, :null => false
    t.integer "cytometer_read_id",              :null => false
    t.string  "well",              :limit => 3, :null => false
  end

  add_index "cytometer_measurement", ["id"], :name => "cytometer_measurement_id_key", :unique => true

  create_table "cytometer_read", :force => true do |t|
    t.integer "instrument_id", :null => false
    t.date    "date",          :null => false
    t.integer "staff_id",      :null => false
    t.text    "file_name",     :null => false
    t.integer "plate_id",      :null => false
    t.integer "read_type_id",  :null => false
  end

  add_index "cytometer_read", ["id"], :name => "cytometer_read_id_key", :unique => true

  create_table "data_file_sets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", :force => true do |t|
    t.string   "content_type"
    t.string   "filepath"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "data_file_set_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "design", :id => false, :force => true do |t|
    t.string  "id",             :limit => 30, :null => false
    t.string  "juul_id",        :limit => 30, :null => false
    t.text    "description"
    t.text    "dna_sequence"
    t.integer "design_type_id",               :null => false
  end

  add_index "design", ["id"], :name => "design_id_key", :unique => true

  create_table "design_feature", :force => true do |t|
    t.string  "design_id",  :limit => 30, :null => false
    t.integer "feature_id",               :null => false
    t.integer "start",                    :null => false
    t.integer "stop",                     :null => false
  end

  create_table "design_strain", :force => true do |t|
    t.string  "design_id", :limit => 30, :null => false
    t.integer "strain_id",               :null => false
  end

  create_table "design_type", :force => true do |t|
    t.text "name",   :null => false
    t.text "prefix", :null => false
  end

  add_index "design_type", ["id"], :name => "design_type_id_key", :unique => true

  create_table "dna_sequence", :force => true do |t|
    t.text "nucleotides", :null => false
  end

  create_table "event", :force => true do |t|
    t.integer "cytometer_measurement_id", :null => false
    t.float   "fluorescence",             :null => false
    t.float   "side_scatter",             :null => false
    t.float   "forward_scatter",          :null => false
  end

  create_table "expression_levels", :force => true do |t|
    t.integer  "promoter_part_id"
    t.integer  "fiveprime_part_id"
    t.string   "plate"
    t.string   "well"
    t.float    "average"
    t.float    "standard_deviation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "normalized"
  end

  create_table "feature", :id => false, :force => true do |t|
    t.integer "id",              :null => false
    t.text    "description",     :null => false
    t.text    "dna_sequence",    :null => false
    t.text    "genbank_type",    :null => false
    t.text    "juul_type",       :null => false
    t.boolean "display_in_view", :null => false
  end

  add_index "feature", ["dna_sequence"], :name => "feature_dna_sequence_unique", :unique => true
  add_index "feature", ["id"], :name => "feature_id_key", :unique => true

  create_table "gene_expression", :force => true do |t|
    t.string "design_id",                   :limit => 30, :null => false
    t.float  "bulk_gene_expression",                      :null => false
    t.float  "bulk_gene_expression_sd",                   :null => false
    t.float  "gene_expression_per_cell",                  :null => false
    t.float  "gene_expression_per_cell_sd",               :null => false
  end

  create_table "instrument", :id => false, :force => true do |t|
    t.integer "id",       :limit => 2, :null => false
    t.text    "type",                  :null => false
    t.text    "model",                 :null => false
    t.text    "make",                  :null => false
    t.text    "location",              :null => false
  end

  add_index "instrument", ["id"], :name => "instrument_id_key", :unique => true

  create_table "measurement", :force => true do |t|
    t.integer "read_id",              :null => false
    t.float   "a1",                   :null => false
    t.float   "a2",                   :null => false
    t.float   "a3",                   :null => false
    t.float   "a4",                   :null => false
    t.float   "a5",                   :null => false
    t.float   "a6",                   :null => false
    t.float   "a7",                   :null => false
    t.float   "a8",                   :null => false
    t.float   "a9",                   :null => false
    t.float   "a10",                  :null => false
    t.float   "a11",                  :null => false
    t.float   "a12",                  :null => false
    t.float   "b1",                   :null => false
    t.float   "b2",                   :null => false
    t.float   "b3",                   :null => false
    t.float   "b4",                   :null => false
    t.float   "b5",                   :null => false
    t.float   "b6",                   :null => false
    t.float   "b7",                   :null => false
    t.float   "b8",                   :null => false
    t.float   "b9",                   :null => false
    t.float   "b10",                  :null => false
    t.float   "b11",                  :null => false
    t.float   "b12",                  :null => false
    t.float   "c1",                   :null => false
    t.float   "c2",                   :null => false
    t.float   "c3",                   :null => false
    t.float   "c4",                   :null => false
    t.float   "c5",                   :null => false
    t.float   "c6",                   :null => false
    t.float   "c7",                   :null => false
    t.float   "c8",                   :null => false
    t.float   "c9",                   :null => false
    t.float   "c10",                  :null => false
    t.float   "c11",                  :null => false
    t.float   "c12",                  :null => false
    t.float   "d1",                   :null => false
    t.float   "d2",                   :null => false
    t.float   "d3",                   :null => false
    t.float   "d4",                   :null => false
    t.float   "d5",                   :null => false
    t.float   "d6",                   :null => false
    t.float   "d7",                   :null => false
    t.float   "d8",                   :null => false
    t.float   "d9",                   :null => false
    t.float   "d10",                  :null => false
    t.float   "d11",                  :null => false
    t.float   "d12",                  :null => false
    t.float   "e1",                   :null => false
    t.float   "e2",                   :null => false
    t.float   "e3",                   :null => false
    t.float   "e4",                   :null => false
    t.float   "e5",                   :null => false
    t.float   "e6",                   :null => false
    t.float   "e7",                   :null => false
    t.float   "e8",                   :null => false
    t.float   "e9",                   :null => false
    t.float   "e10",                  :null => false
    t.float   "e11",                  :null => false
    t.float   "e12",                  :null => false
    t.float   "f1",                   :null => false
    t.float   "f2",                   :null => false
    t.float   "f3",                   :null => false
    t.float   "f4",                   :null => false
    t.float   "f5",                   :null => false
    t.float   "f6",                   :null => false
    t.float   "f7",                   :null => false
    t.float   "f8",                   :null => false
    t.float   "f9",                   :null => false
    t.float   "f10",                  :null => false
    t.float   "f11",                  :null => false
    t.float   "f12",                  :null => false
    t.float   "g1",                   :null => false
    t.float   "g2",                   :null => false
    t.float   "g3",                   :null => false
    t.float   "g4",                   :null => false
    t.float   "g5",                   :null => false
    t.float   "g6",                   :null => false
    t.float   "g7",                   :null => false
    t.float   "g8",                   :null => false
    t.float   "g9",                   :null => false
    t.float   "g10",                  :null => false
    t.float   "g11",                  :null => false
    t.float   "g12",                  :null => false
    t.float   "h1",                   :null => false
    t.float   "h2",                   :null => false
    t.float   "h3",                   :null => false
    t.float   "h4",                   :null => false
    t.float   "h5",                   :null => false
    t.float   "h6",                   :null => false
    t.float   "h7",                   :null => false
    t.float   "h8",                   :null => false
    t.float   "h9",                   :null => false
    t.float   "h10",                  :null => false
    t.float   "h11",                  :null => false
    t.float   "h12",                  :null => false
    t.time    "time",    :limit => 6, :null => false
  end

  create_table "part_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts", :force => true do |t|
    t.integer  "part_type_id"
    t.string   "name"
    t.string   "description"
    t.string   "sequence"
    t.string   "col"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performance_summary", :id => false, :force => true do |t|
    t.integer "id",                                        :null => false
    t.string  "design_id",                   :limit => 30, :null => false
    t.float   "bulk_gene_expression",                      :null => false
    t.float   "bulk_gene_expression_sd",                   :null => false
    t.float   "gene_expression_per_cell",                  :null => false
    t.float   "gene_expression_per_cell_sd",               :null => false
  end

  create_table "plate", :id => false, :force => true do |t|
    t.integer "id",                        :null => false
    t.text    "freezer",                   :null => false
    t.text    "box",                       :null => false
    t.text    "description",               :null => false
    t.string  "juul_id",     :limit => 30, :null => false
  end

  add_index "plate", ["id"], :name => "plate_id_key", :unique => true

  create_table "read", :force => true do |t|
    t.integer "instrument_id", :null => false
    t.date    "date",          :null => false
    t.integer "staff_id",      :null => false
    t.text    "file_name",     :null => false
    t.integer "plate_id",      :null => false
    t.integer "read_type_id",  :null => false
  end

  add_index "read", ["id"], :name => "plate_read_id_key", :unique => true

  create_table "read_type", :force => true do |t|
    t.text   "name",                     :null => false
    t.text   "description",              :null => false
    t.string "code",        :limit => 3, :null => false
  end

  add_index "read_type", ["id"], :name => "read_type_id_key", :unique => true

  create_table "scores", :force => true do |t|
    t.integer  "exp1_id"
    t.integer  "exp2_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff", :force => true do |t|
    t.text "first_name"
    t.text "last_name"
  end

  add_index "staff", ["id"], :name => "staff_id_key", :unique => true

  create_table "strain", :force => true do |t|
    t.text "juul_id",     :null => false
    t.text "chassis"
    t.text "description"
  end

  add_index "strain", ["id"], :name => "strain_id_key", :unique => true
  add_index "strain", ["juul_id"], :name => "strain_juul_id_unique", :unique => true

  create_table "strain_plate", :force => true do |t|
    t.integer "strain_id",              :null => false
    t.integer "plate_id",               :null => false
    t.string  "well",      :limit => 3, :null => false
  end

  create_table "terminator_performance", :id => false, :force => true do |t|
    t.integer "id",                                      :null => false
    t.integer "collection_id",                           :null => false
    t.integer "feature_id",                              :null => false
    t.integer "part_id",                                 :null => false
    t.string  "part_juul_id",              :limit => 30, :null => false
    t.text    "description",                             :null => false
    t.text    "part_type",                               :null => false
    t.string  "construct_juul_id",         :limit => 30, :null => false
    t.string  "strain_juul_id",            :limit => 30, :null => false
    t.text    "part_dna_sequence",                       :null => false
    t.float   "termination_efficiency",                  :null => false
    t.float   "termination_efficiency_sd",               :null => false
  end

  add_index "terminator_performance", ["part_dna_sequence"], :name => "part_dna_sequence_unique", :unique => true

  create_table "terminator_performance_summary", :id => false, :force => true do |t|
    t.integer "id",                                      :null => false
    t.string  "juul_id",                   :limit => 30, :null => false
    t.text    "description",                             :null => false
    t.float   "termination_efficiency",                  :null => false
    t.float   "termination_efficiency_sd",               :null => false
    t.text    "dna_sequence",                            :null => false
  end

  add_index "terminator_performance_summary", ["dna_sequence"], :name => "terminator_sequence_unique", :unique => true

end
