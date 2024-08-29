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

ActiveRecord::Schema.define(version: 2022_03_27_004200) do

  create_table "addresses", force: :cascade do |t|
    t.string "recipient"
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.boolean "active", default: true
    t.integer "customer_id"
    t.boolean "is_billing", default: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.boolean "active", default: true
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "item_prices", force: :cascade do |t|
    t.integer "item_id"
    t.float "price"
    t.date "start_date"
    t.date "end_date"
    t.index ["item_id"], name: "index_item_prices_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "color"
    t.integer "inventory_level"
    t.integer "reorder_level"
    t.integer "category_id"
    t.float "weight"
    t.boolean "is_featured", default: false
    t.boolean "active", default: true
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.integer "quantity"
    t.date "shipped_on"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "address_id"
    t.date "date"
    t.float "products_total"
    t.float "shipping"
    t.string "payment_receipt"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "greeting"
    t.string "role"
    t.boolean "active", default: true
  end

end
