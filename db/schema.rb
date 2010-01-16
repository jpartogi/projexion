# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091013000428) do

  create_table "acceptances", :force => true do |t|
    t.string   "description",                    :null => false
    t.boolean  "accepted",    :default => false, :null => false
    t.integer  "feature_id",                     :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "action",                    :null => false
    t.string   "model",      :limit => 100, :null => false
    t.integer  "model_id",                  :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "created_at",                :null => false
  end

  create_table "features", :force => true do |t|
    t.text     "user_story",                                                                    :null => false
    t.decimal  "business_value",              :precision => 10, :scale => 0
    t.integer  "story_points"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sprint_id"
    t.integer  "release_id"
    t.string   "project_code",   :limit => 3,                                                   :null => false
    t.boolean  "accepted",                                                   :default => false, :null => false
  end

  create_table "meeting_types", :force => true do |t|
    t.string   "name",        :limit => 50, :null => false
    t.text     "description",               :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "created_at",                :null => false
  end

  create_table "meetings", :force => true do |t|
    t.text     "notes",                        :null => false
    t.binary   "attachment"
    t.datetime "start_time",                   :null => false
    t.datetime "end_time",                     :null => false
    t.integer  "meeting_type_id",              :null => false
    t.string   "project_code",    :limit => 3, :null => false
    t.integer  "sprint_id",                    :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "project_members", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "project_role", :limit => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :primary_key => "code", :force => true do |t|
    t.string   "name",       :limit => 25, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vision",                   :null => false
  end

  create_table "releases", :force => true do |t|
    t.string   "version_number", :limit => 20, :null => false
    t.date     "estimate_date"
    t.string   "project_code",   :limit => 3,  :null => false
    t.datetime "cancelled_at"
    t.datetime "released_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprints", :force => true do |t|
    t.date     "start_date",                 :null => false
    t.date     "end_date",                   :null => false
    t.text     "retrospective"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "project_code",  :limit => 3, :null => false
    t.string   "goal"
    t.datetime "cancelled_at"
  end

  create_table "task_dailies", :force => true do |t|
    t.string    "project_code", :limit => 3, :null => false
    t.integer   "total_tasks",               :null => false
    t.date      "last_update",               :null => false
    t.timestamp "tstamp",                    :null => false
    t.datetime  "updated_at",                :null => false
    t.datetime  "created_at",                :null => false
  end

  create_table "task_statuses", :force => true do |t|
    t.string   "display_name",   :limit => 100, :null => false
    t.string   "key",            :limit => 100, :null => false
    t.integer  "position"
    t.boolean  "default_status"
    t.string   "color",          :limit => 7,   :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tasks", :force => true do |t|
    t.text     "description",                    :null => false
    t.string   "project_code",      :limit => 3, :null => false
    t.integer  "feature_id",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_status_id",                 :null => false
    t.integer  "project_member_id"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
