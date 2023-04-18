# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_16_045039) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmark_tag_relations", force: :cascade do |t|
    t.bigint "bookmark_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookmark_id"], name: "index_bookmark_tag_relations_on_bookmark_id"
    t.index ["tag_id", "bookmark_id"], name: "index_bookmark_tag_relations_on_tag_id_and_bookmark_id", unique: true
    t.index ["tag_id"], name: "index_bookmark_tag_relations_on_tag_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_isbn", null: false
    t.text "headline", null: false
    t.text "body", null: false
    t.text "page"
    t.text "chapter"
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_isbn"], name: "index_bookmarks_on_book_isbn"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "books", primary_key: "isbn", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.text "sales_date"
    t.text "large_image_url"
    t.text "item_url"
    t.text "item_caption"
    t.string "item_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clicks", force: :cascade do |t|
    t.bigint "book_isbn", null: false
    t.integer "clicks", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_isbn"], name: "index_clicks_on_book_isbn"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qiita_tags", force: :cascade do |t|
    t.string "name"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "bookmark_tag_relations", "bookmarks"
  add_foreign_key "bookmark_tag_relations", "tags"
  add_foreign_key "bookmarks", "books", column: "book_isbn", primary_key: "isbn"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "clicks", "books", column: "book_isbn", primary_key: "isbn"
end
