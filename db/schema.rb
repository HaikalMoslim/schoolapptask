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

ActiveRecord::Schema[7.1].define(version: 2024_03_19_052057) do
  create_table "enrollments", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_enrollments_on_student_id"
    t.index ["teacher_id"], name: "index_enrollments_on_teacher_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "payment_id"
    t.integer "order_number"
    t.string "payment_method"
    t.string "payment_status"
    t.string "receipt_url"
    t.string "status_url"
    t.string "buyer_email"
    t.string "buyer_name"
    t.string "buyer_phone"
    t.float "transaction_amount"
    t.string "retry_url"
    t.integer "receipt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receipt_id"], name: "index_payments_on_receipt_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "teacher_id"
    t.index ["teacher_id"], name: "index_receipts_on_teacher_id"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "enrollments", "students"
  add_foreign_key "enrollments", "teachers"
  add_foreign_key "payments", "receipts"
  add_foreign_key "receipts", "teachers"
  add_foreign_key "receipts", "users"
  add_foreign_key "students", "users"
  add_foreign_key "teachers", "users"
end
