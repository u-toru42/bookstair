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

ActiveRecord::Schema[7.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "book_id"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "bookauthors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookchecks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bookshelf_line_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_bookchecks_on_book_id"
    t.index ["bookshelf_line_id"], name: "index_bookchecks_on_bookshelf_line_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_bookmarks_on_book_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.bigint "isbn"
    t.string "url"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookshelf_boards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "bookshelf_follow_id"
    t.index ["bookshelf_follow_id"], name: "index_bookshelf_boards_on_bookshelf_follow_id"
    t.index ["user_id"], name: "index_bookshelf_boards_on_user_id"
  end

  create_table "bookshelf_follows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bookshelf_board_id"
    t.bigint "bookshelf_id"
    t.index ["bookshelf_board_id"], name: "index_bookshelf_follows_on_bookshelf_board_id"
    t.index ["bookshelf_id"], name: "index_bookshelf_follows_on_bookshelf_id"
  end

  create_table "bookshelf_lines", force: :cascade do |t|
    t.string "title"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bookshelf_id"
    t.index ["bookshelf_id"], name: "index_bookshelf_lines_on_bookshelf_id"
  end

  create_table "bookshelves", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_comments_on_book_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "status"
    t.integer "comprehension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tag_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_taggings_on_book_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
