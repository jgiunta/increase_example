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

ActiveRecord::Schema.define(version: 20210701214202) do

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "client_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "job"
    t.string   "country"
    t.string   "address"
    t.string   "zip_code"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "discount_id"
    t.integer  "amount"
    t.integer  "kind"
    t.integer  "payment_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["payment_id"], name: "index_discounts_on_payment_id", using: :btree
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "payment_id"
    t.integer  "coin"
    t.integer  "total_amount"
    t.integer  "total_discount"
    t.integer  "total_with_discounts"
    t.integer  "client_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "payment_date"
    t.index ["client_id"], name: "index_payments_on_client_id", using: :btree
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "transaction_id"
    t.integer  "amount"
    t.integer  "kind"
    t.integer  "payment_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["payment_id"], name: "index_transactions_on_payment_id", using: :btree
  end

  add_foreign_key "discounts", "payments"
  add_foreign_key "payments", "clients"
  add_foreign_key "transactions", "payments"
end
