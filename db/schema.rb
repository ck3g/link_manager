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

ActiveRecord::Schema.define(:version => 20120701113419) do

  create_table "access_list_users_our_sites", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "our_site_id"
  end

  add_index "access_list_users_our_sites", ["our_site_id"], :name => "index_access_list_users_our_sites_on_our_site_id"
  add_index "access_list_users_our_sites", ["user_id"], :name => "index_access_list_users_our_sites_on_user_id"

  create_table "access_list_users_payment_methods", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "payment_method_id"
  end

  add_index "access_list_users_payment_methods", ["payment_method_id"], :name => "index_access_list_users_payment_methods_on_payment_method_id"
  add_index "access_list_users_payment_methods", ["user_id"], :name => "index_access_list_users_payment_methods_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "gritter_notices", :force => true do |t|
    t.integer  "owner_id",     :null => false
    t.string   "owner_type",   :null => false
    t.text     "text",         :null => false
    t.text     "options",      :null => false
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gritter_notices", ["owner_id", "delivered_at"], :name => "index_gritter_notices_on_owner_id_and_delivered_at"

  create_table "links", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "page_rank"
    t.string   "keyword"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.integer  "placement_id"
    t.integer  "our_site_id"
    t.boolean  "inactive",     :default => false
  end

  add_index "links", ["our_site_id"], :name => "index_links_on_our_site_id"
  add_index "links", ["placement_id"], :name => "index_links_on_placement_id"
  add_index "links", ["status_id"], :name => "index_links_on_status_id"
  add_index "links", ["user_id"], :name => "index_links_on_user_id"

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "link_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["link_id"], :name => "index_logs_on_link_id"
  add_index "logs", ["user_id"], :name => "index_logs_on_user_id"

  create_table "our_sites", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "our_sites", ["category_id"], :name => "index_our_sites_on_category_id"
  add_index "our_sites", ["name"], :name => "index_our_sites_on_name", :unique => true

  create_table "payment_methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "link_id"
    t.integer  "user_id"
    t.float    "amount"
    t.integer  "seller_id"
    t.integer  "payment_method_id"
    t.datetime "paid_at"
    t.datetime "next_payment_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "moderated",         :default => false
  end

  add_index "payments", ["link_id"], :name => "index_payments_on_link_id"
  add_index "payments", ["payment_method_id"], :name => "index_payments_on_payment_method_id"
  add_index "payments", ["seller_id"], :name => "index_payments_on_seller_id"
  add_index "payments", ["user_id"], :name => "index_payments_on_user_id"

  create_table "placements", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seller_origins", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sellers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wm_wallet"
    t.integer  "seller_origin_id"
  end

  add_index "sellers", ["seller_origin_id"], :name => "index_sellers_on_seller_origin_id"

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                                  :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"

end
