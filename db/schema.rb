# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120327090143) do

  create_table "applications", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "finishes", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "material_id"
    t.integer  "finish_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["finish_id"], :name => "index_images_on_finish_id"
  add_index "images", ["material_id"], :name => "index_images_on_material_id"

  create_table "material_applications", :force => true do |t|
    t.integer "material_id"
    t.integer "application_id"
  end

  add_index "material_applications", ["material_id", "application_id"], :name => "index_material_applications_on_material_id_and_application_id"

  create_table "material_finishes", :force => true do |t|
    t.integer "material_id"
    t.integer "finish_id"
  end

  add_index "material_finishes", ["material_id", "finish_id"], :name => "index_material_finishes_on_material_id_and_finish_id"

  create_table "material_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "materials", :force => true do |t|
    t.string   "title"
    t.integer  "material_type_id"
    t.integer  "default_image_id"
    t.integer  "pdf_id"
    t.text     "description"
    t.text     "specifications"
    t.text     "technical_data"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "cached_slug"
  end

  add_index "materials", ["cached_slug"], :name => "index_materials_on_cached_slug"
  add_index "materials", ["default_image_id"], :name => "index_materials_on_default_image_id"
  add_index "materials", ["material_type_id"], :name => "index_materials_on_material_type_id"

  create_table "pdfs", :force => true do |t|
    t.string   "orig_filename"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "slugs", :force => true do |t|
    t.string   "scope"
    t.string   "slug"
    t.integer  "record_id"
    t.datetime "created_at"
  end

  add_index "slugs", ["scope", "record_id", "created_at"], :name => "index_slugs_on_scope_and_record_id_and_created_at"
  add_index "slugs", ["scope", "record_id"], :name => "index_slugs_on_scope_and_record_id"
  add_index "slugs", ["scope", "slug", "created_at"], :name => "index_slugs_on_scope_and_slug_and_created_at"
  add_index "slugs", ["scope", "slug"], :name => "index_slugs_on_scope_and_slug"

end
