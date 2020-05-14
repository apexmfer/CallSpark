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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_20_135027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_managers", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "initials"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bi_customers", primary_key: "no", id: :integer, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "customer_type"
    t.integer "bi_outside_sales_rep_id"
    t.integer "bi_inside_sales_rep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bi_inside_sales_rep_id"], name: "bi_inside_sales_rep_id_ix"
    t.index ["bi_outside_sales_rep_id"], name: "bi_outside_sales_rep_id_ix"
  end

  create_table "bi_inside_sales_reps", id: :serial, force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bi_orders", id: :serial, force: :cascade do |t|
    t.integer "order_number", null: false
    t.integer "order_suffix"
    t.integer "line_number"
    t.string "ship_prod"
    t.string "prod_desc"
    t.string "warehouse"
    t.integer "bi_customer_no"
    t.string "customer_po"
    t.string "ship_to_name"
    t.string "ship_to_address1"
    t.string "ship_to_city"
    t.string "ship_to_state"
    t.integer "prod_cost_cents"
    t.integer "price_cents"
    t.integer "sales_cents"
    t.integer "bi_inside_sales_rep_id"
    t.integer "bi_outside_sales_rep_id"
    t.string "prod_category"
    t.bigint "bi_vendor_no"
    t.integer "qty_ord"
    t.datetime "enter_date"
    t.datetime "promise_date"
    t.datetime "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bi_customer_no"], name: "bi_order_customer_no_ix"
    t.index ["bi_vendor_no"], name: "bi_order_vendor_no_ix"
  end

  create_table "bi_outside_sales_reps", id: :serial, force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bi_quotes", id: :serial, force: :cascade do |t|
    t.integer "order_number", null: false
    t.integer "order_suffix"
    t.integer "line_number"
    t.string "ship_prod"
    t.string "prod_desc"
    t.string "warehouse"
    t.integer "bi_customer_no"
    t.string "customer_po"
    t.string "ship_to_name"
    t.string "ship_to_address1"
    t.string "ship_to_city"
    t.string "ship_to_state"
    t.integer "prod_cost_cents"
    t.integer "price_cents"
    t.integer "sales_cents"
    t.integer "bi_inside_sales_rep_id"
    t.integer "bi_outside_sales_rep_id"
    t.string "prod_category"
    t.bigint "bi_vendor_no"
    t.integer "qty_ord"
    t.datetime "enter_date"
    t.datetime "promise_date"
    t.datetime "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bi_customer_no"], name: "bi_quote_customer_no_ix"
    t.index ["bi_vendor_no"], name: "bi_quote_vendor_no_ix"
  end

  create_table "bi_vendors", primary_key: "no", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calls", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "category_id"
    t.text "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "region_id"
    t.datetime "called_at"
    t.integer "initiative_id"
    t.text "question_for_call"
    t.text "resolution_for_call"
    t.boolean "notified_account_manager"
    t.integer "product_vendor_id"
    t.integer "origin_type"
    t.index ["region_id"], name: "index_calls_on_region_id"
  end

  create_table "casein_admin_users", id: :serial, force: :cascade do |t|
    t.string "login", null: false
    t.string "name"
    t.string "email"
    t.integer "access_level", default: 0, null: false
    t.string "crypted_password", null: false
    t.string "password_salt", null: false
    t.string "persistence_token"
    t.string "single_access_token"
    t.string "perishable_token"
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip"
    t.string "last_login_ip"
    t.string "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cases", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_hints", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.integer "parent_id"
    t.text "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkouts", id: :serial, force: :cascade do |t|
    t.integer "checkout_user_id"
    t.integer "hardware_id"
    t.integer "customer_id"
    t.datetime "time_out"
    t.datetime "expected_time_in"
    t.datetime "actual_time_in"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "BPID"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "address"
    t.integer "bi_customer_no"
    t.integer "service_contract_type"
    t.integer "mcmc_account_number"
    t.integer "account_manager_id"
    t.index ["bi_customer_no"], name: "bi_customer_no_ix"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "company_id"
    t.text "notes"
    t.integer "region_id"
    t.integer "job_role_id"
    t.index ["region_id"], name: "index_customers_on_region_id"
  end

  create_table "demohardwares", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "barcode"
    t.string "series"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", id: :serial, force: :cascade do |t|
    t.integer "favorited_id"
    t.string "favorited_type"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["favorited_type", "favorited_id"], name: "index_favorites_on_favorited_type_and_favorited_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "initiative_targets", id: :serial, force: :cascade do |t|
    t.integer "bi_targetted_id"
    t.string "bi_targetted_type"
    t.integer "initiative_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bi_targetted_id", "bi_targetted_type"], name: "bi_initiative_targets_ix"
  end

  create_table "initiatives", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partdetails", id: :serial, force: :cascade do |t|
    t.string "catalog_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
  end

  create_table "product_segment_focus", id: :serial, force: :cascade do |t|
    t.integer "focused_id"
    t.string "focused_type"
    t.integer "product_segment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["focused_id", "focused_type"], name: "bi_product_segment_focus_ix"
  end

  create_table "product_segments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_vendors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_assignments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "customer_id"
    t.integer "primary_company_id"
    t.integer "secondary_company_id"
    t.string "name"
    t.string "quote_id"
    t.datetime "start_date"
    t.datetime "data_received_date"
    t.datetime "sized_date"
    t.datetime "proposal_date"
    t.datetime "follow_up_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "status"
    t.integer "cost_estimate_cents"
  end

  create_table "regions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales_metrics", id: :serial, force: :cascade do |t|
    t.integer "metric_type"
    t.bigint "bi_vendor_no"
    t.integer "bi_customer_no"
    t.integer "value_cents"
    t.integer "measured_count"
    t.integer "measured_id"
    t.string "measured_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bi_customer_no"], name: "metric_customer_no_ix"
    t.index ["bi_vendor_no"], name: "metric_vendor_no_ix"
    t.index ["measured_id", "measured_type"], name: "bi_sales_metric_measured_ix"
    t.index ["metric_type"], name: "index_sales_metrics_on_metric_type"
  end

  create_table "supportlinks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "sortorder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "firstname"
    t.string "lastname"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "privilege_level"
    t.integer "bi_outside_sales_rep_id"
    t.string "bi_outside_sales_rep_code"
    t.boolean "receive_outside_sales_emails"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
