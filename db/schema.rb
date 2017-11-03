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

ActiveRecord::Schema.define(version: 20171027140641) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "value", limit: 24, default: 0.0, null: false
    t.string "name", null: false
    t.bigint "corporate_entity_id"
    t.bigint "individual_entity_id"
    t.bigint "account_id"
    t.integer "level", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_accounts_on_account_id"
    t.index ["corporate_entity_id"], name: "index_accounts_on_corporate_entity_id"
    t.index ["individual_entity_id"], name: "index_accounts_on_individual_entity_id"
  end

  create_table "corporate_entities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cnpj", null: false
    t.string "business", null: false
    t.string "trading_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnpj"], name: "index_corporate_entities_on_cnpj", unique: true
  end

  create_table "financial_contributions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "value", limit: 24, null: false
    t.bigint "account_id", null: false
    t.string "code", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_financial_contributions_on_account_id"
    t.index ["code"], name: "index_financial_contributions_on_code", unique: true
  end

  create_table "financial_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "value", limit: 24, null: false
    t.bigint "origin_id", null: false
    t.bigint "destination_id", null: false
    t.string "code", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_financial_transactions_on_code", unique: true
    t.index ["destination_id"], name: "index_financial_transactions_on_destination_id"
    t.index ["origin_id"], name: "index_financial_transactions_on_origin_id"
  end

  create_table "individual_entities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cpf", null: false
    t.string "full_name", null: false
    t.date "date_birth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_individual_entities_on_cpf", unique: true
  end

  add_foreign_key "accounts", "accounts", on_delete: :cascade
  add_foreign_key "accounts", "corporate_entities", on_delete: :cascade
  add_foreign_key "accounts", "individual_entities", on_delete: :cascade
  add_foreign_key "financial_contributions", "accounts"
  add_foreign_key "financial_transactions", "accounts", column: "destination_id"
  add_foreign_key "financial_transactions", "accounts", column: "origin_id"
end
