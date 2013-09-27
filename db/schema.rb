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

ActiveRecord::Schema.define(:version => 20130722114758) do

  create_table "alerts", :force => true do |t|
    t.datetime "date_start",       :null => false
    t.datetime "date_end",         :null => false
    t.integer  "check_status",     :null => false
    t.string   "service_output"
    t.string   "service_perfdata"
    t.integer  "duration",         :null => false
    t.integer  "service_id"
    t.integer  "report_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "host_id"
  end

  create_table "current_alerts", :force => true do |t|
    t.string   "hostname"
    t.string   "description"
    t.integer  "check_status"
    t.integer  "check_date"
    t.string   "service_output"
    t.string   "service_perfdata"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "current_alerts_import", :force => true do |t|
    t.string   "hostname"
    t.string   "description"
    t.integer  "check_status"
    t.integer  "check_date"
    t.string   "service_output"
    t.string   "service_perfdata"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "hosts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "notification_delay"
  end

  create_table "hosts_hosttags", :id => false, :force => true do |t|
    t.integer "hosttag_id", :null => false
    t.integer "host_id",    :null => false
  end

  create_table "hosttags", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "css_classes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "import_from_nagios_logs", :force => true do |t|
    t.string   "hostname"
    t.string   "description"
    t.integer  "check_status"
    t.integer  "check_date"
    t.string   "service_output"
    t.string   "service_perfdata"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "reports", :force => true do |t|
    t.string   "label",                          :null => false
    t.string   "description"
    t.datetime "estimated_date"
    t.integer  "select_priority", :default => 0, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "reports_reporttags", :id => false, :force => true do |t|
    t.integer "reporttag_id", :null => false
    t.integer "report_id",    :null => false
  end

  create_table "reporttags", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "description"
    t.string   "css_classes"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "exclude_from_stats", :default => 0, :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "host_id"
    t.integer  "notification_delay"
  end

  create_table "services_servicetags", :id => false, :force => true do |t|
    t.integer "servicetag_id", :null => false
    t.integer "service_id",    :null => false
  end

  create_table "servicetags", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "css_classes"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
