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

  add_index "acceptances", ["description"], :name => "acceptances_desc_idx"
  add_index "acceptances", ["id", "feature_id"], :name => "acceptances_idx"

  create_table "audits", :force => true do |t|
    t.string   "old_value",     :null => false
    t.string   "new_value",     :null => false
    t.string   "model",         :null => false
    t.string   "changed_field", :null => false
    t.integer  "model_id",      :null => false
    t.string   "event_id"
    t.datetime "updated_at",    :null => false
    t.datetime "created_at",    :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "action",                    :null => false
    t.string   "model",      :limit => 100, :null => false
    t.integer  "model_id",                  :null => false
    t.integer  "project_id",                :null => false
    t.integer  "user_id",                   :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "created_at",                :null => false
  end

  add_index "events", ["action"], :name => "events_action_idx"
  add_index "events", ["id", "project_id", "user_id"], :name => "events_idx"

  create_table "feature_statuses", :force => true do |t|
    t.string   "display_name",   :limit => 45,                    :null => false
    t.string   "key",            :limit => 45,                    :null => false
    t.integer  "position",       :limit => 3,  :default => 1,     :null => false
    t.string   "color",          :limit => 6,                     :null => false
    t.boolean  "default_status",               :default => false, :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "features", :force => true do |t|
    t.string   "user_story",                                       :null => false
    t.decimal  "business_value",    :precision => 10, :scale => 0
    t.integer  "story_points"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "sprint_id"
    t.integer  "release_id"
    t.string   "changes"
    t.integer  "priority_id",                                      :null => false
    t.integer  "project_id",                                       :null => false
    t.integer  "feature_status_id",                                :null => false
  end

  add_index "features", ["id", "sprint_id", "release_id", "project_id"], :name => "features_idx"
  add_index "features", ["user_story"], :name => "features_story_idx"

  create_table "meeting_types", :force => true do |t|
    t.string   "name",        :limit => 50, :null => false
    t.text     "occurrence"
    t.text     "description",               :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "created_at",                :null => false
  end

  create_table "meetings", :force => true do |t|
    t.text     "minutes"
    t.binary   "attachment"
    t.datetime "start_time",      :null => false
    t.datetime "end_time",        :null => false
    t.integer  "meeting_type_id", :null => false
    t.text     "location"
    t.text     "agenda"
    t.text     "additionals"
    t.integer  "project_id",      :null => false
    t.integer  "sprint_id"
    t.datetime "cancelled_at"
    t.text     "created_by",      :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "meetings", ["id", "meeting_type_id", "project_id", "sprint_id"], :name => "meetings_idx"

  create_table "priorities", :force => true do |t|
    t.string   "display_name", :limit => 45,                    :null => false
    t.string   "color",        :limit => 45,                    :null => false
    t.integer  "level",        :limit => 3,                     :null => false
    t.boolean  "default",                    :default => false, :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "project_members", :force => true do |t|
    t.integer  "project_id",                                    :null => false
    t.integer  "user_id",                                       :null => false
    t.integer  "project_role_id",                               :null => false
    t.string   "status",          :limit => 1, :default => "A", :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "project_members", ["project_id", "user_id", "project_role_id"], :name => "project_members_idx"
  add_index "project_members", ["project_id", "user_id"], :name => "project_members_uq", :unique => true

  create_table "project_roles", :force => true do |t|
    t.string   "name",       :limit => 45,                    :null => false
    t.text     "role"
    t.boolean  "manager",                  :default => false, :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "code",       :limit => 3,  :null => false
    t.string   "name",       :limit => 25, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "vision",                   :null => false
  end

  add_index "projects", ["code"], :name => "projects_code_idx"
  add_index "projects", ["code"], :name => "projects_uq", :unique => true
  add_index "projects", ["name"], :name => "projects_name_idx"

  create_table "release_snapshots", :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "release_id", :null => false
    t.integer  "sprint_id",  :null => false
    t.integer  "total",      :null => false
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "releases", :force => true do |t|
    t.string   "version_number", :limit => 20, :null => false
    t.date     "estimate_date"
    t.text     "goal"
    t.integer  "project_id",                   :null => false
    t.datetime "cancelled_at"
    t.datetime "released_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "releases", ["id", "project_id"], :name => "releases_idx"
  add_index "releases", ["version_number"], :name => "releases_version_idx"

  create_table "sprint_snapshots", :force => true do |t|
    t.integer   "project_id",  :null => false
    t.integer   "total",       :null => false
    t.date      "last_update", :null => false
    t.timestamp "updated",     :null => false
    t.integer   "sprint_id",   :null => false
    t.datetime  "updated_at",  :null => false
    t.datetime  "created_at",  :null => false
  end

  create_table "sprints", :force => true do |t|
    t.date     "start_date",                               :null => false
    t.date     "end_date",                                 :null => false
    t.integer  "velocities",   :limit => 3, :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "project_id",                               :null => false
    t.integer  "release_id",                               :null => false
    t.string   "goal"
    t.datetime "cancelled_at"
  end

  add_index "sprints", ["id", "project_id"], :name => "sprints_idx"

  create_table "task_statuses", :force => true do |t|
    t.string   "display_name",   :limit => 100,                :null => false
    t.string   "key",            :limit => 100,                :null => false
    t.integer  "position",                      :default => 1
    t.boolean  "default_status"
    t.string   "color",          :limit => 7,                  :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "tasks", :force => true do |t|
    t.text     "description",    :null => false
    t.integer  "project_id",     :null => false
    t.integer  "feature_id",     :null => false
    t.integer  "sprint_id",      :null => false
    t.integer  "user_id",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "task_status_id", :null => false
  end

  add_index "tasks", ["id", "project_id", "feature_id", "sprint_id", "task_status_id"], :name => "tasks_idx"

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.boolean  "admin",               :default => false, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "users_email_idx"
  add_index "users", ["login", "email"], :name => "users_uq", :unique => true
  add_index "users", ["login"], :name => "users_login_idx"

end
