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

ActiveRecord::Schema.define(version: 20200402023457) do

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "max_group_size"
    t.integer  "min_group_size"
    t.string   "topics"
    t.boolean  "hardware"
    t.boolean  "industry_sponsored"
    t.string   "client"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "section_id"
    t.index ["section_id"], name: "index_projects_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "course"
    t.string   "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "topics"
    t.boolean  "hardware"
    t.string   "electives"
    t.string   "preferences"
    t.integer  "section_id"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["project_id"], name: "index_students_on_project_id"
    t.index ["section_id"], name: "index_students_on_section_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
