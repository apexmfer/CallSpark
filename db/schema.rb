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

ActiveRecord::Schema.define(:version => 20160922143433) do

  create_table "accountassignments", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "bpid"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "calls", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "category_id"
    t.text     "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "region_id"
  end

  add_index "calls", ["region_id"], :name => "index_calls_on_region_id"

  create_table "cases", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "category_hints", :force => true do |t|
    t.integer  "category_id"
    t.integer  "parent_id"
    t.text     "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "checkouts", :force => true do |t|
    t.integer  "checkout_user_id"
    t.integer  "hardware_id"
    t.integer  "customer_id"
    t.datetime "time_out"
    t.datetime "expected_time_in"
    t.datetime "actual_time_in"
    t.text     "notes"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "BPID"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "address"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "company_id"
    t.text     "notes"
    t.integer  "region_id"
  end

  add_index "customers", ["region_id"], :name => "index_customers_on_region_id"

  create_table "demohardwares", :force => true do |t|
    t.integer  "product_id"
    t.integer  "barcode"
    t.string   "series"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "initials"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "partdetails", :force => true do |t|
    t.string   "catalog_number"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "supportlinks", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "sortorder"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                           :null => false
    t.string   "crypted_password",                :null => false
    t.string   "salt",                            :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
