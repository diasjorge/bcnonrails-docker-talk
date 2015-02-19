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

ActiveRecord::Schema.define(:version => 20120315145922) do

  create_table "blurbs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "key"
    t.integer  "project_id"
  end

  add_index "blurbs", ["project_id", "key"], :name => "index_blurbs_on_project_id_and_key", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "attempts",   :default => 0
    t.datetime "failed_at"
    t.text     "handler"
    t.text     "last_error"
    t.datetime "locked_at"
    t.string   "locked_by"
    t.integer  "priority",   :default => 0
    t.datetime "run_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "locales", :force => true do |t|
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "enabled",    :default => true, :null => false
    t.string   "key"
    t.integer  "project_id"
  end

  add_index "locales", ["project_id", "key"], :name => "index_locales_on_project_id_and_key", :unique => true

  create_table "localizations", :force => true do |t|
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "blurb_id"
    t.text     "draft_content",        :default => "", :null => false
    t.integer  "locale_id"
    t.text     "published_content",    :default => "", :null => false
    t.integer  "published_version_id"
  end

  add_index "localizations", ["blurb_id"], :name => "index_localizations_on_blurb_id"

  create_table "projects", :force => true do |t|
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "api_key"
    t.boolean  "archived",           :default => false,    :null => false
    t.integer  "draft_cache_id"
    t.string   "name"
    t.string   "password",           :default => "copter", :null => false
    t.integer  "published_cache_id"
    t.string   "username",           :default => "copy",   :null => false
  end

  add_index "projects", ["archived"], :name => "index_projects_on_archived"

  create_table "text_caches", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "data"
    t.text     "hierarchichal_data"
  end

  create_table "versions", :force => true do |t|
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "content",         :default => "", :null => false
    t.integer  "localization_id"
    t.integer  "number",                          :null => false
  end

  add_index "versions", ["localization_id"], :name => "index_versions_on_localization_id"

end
