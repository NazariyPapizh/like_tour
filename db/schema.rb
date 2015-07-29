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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150122154629) do

  create_table "about_translations", force: true do |t|
    t.integer  "about_id",    null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "about_translations", ["about_id"], name: "index_about_translations_on_about_id"
  add_index "about_translations", ["locale"], name: "index_about_translations_on_locale"

  create_table "abouts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_start"
  end

  create_table "brand_carousel_translations", force: true do |t|
    t.integer  "brand_carousel_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.string   "link"
  end

  add_index "brand_carousel_translations", ["brand_carousel_id"], name: "index_brand_carousel_translations_on_brand_carousel_id"
  add_index "brand_carousel_translations", ["locale"], name: "index_brand_carousel_translations_on_locale"

  create_table "brand_carousels", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "link"
    t.boolean  "published"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
    t.integer  "index_sort"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "category_translations", force: true do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "description"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "city_joins", force: true do |t|
    t.integer  "tour_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "city_translations", force: true do |t|
    t.integer  "city_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
  end

  add_index "city_translations", ["city_id"], name: "index_city_translations_on_city_id"
  add_index "city_translations", ["locale"], name: "index_city_translations_on_locale"

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "contacts_info_translations", force: true do |t|
    t.integer  "contacts_info_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "city"
  end

  add_index "contacts_info_translations", ["contacts_info_id"], name: "index_contacts_info_translations_on_contacts_info_id"
  add_index "contacts_info_translations", ["locale"], name: "index_contacts_info_translations_on_locale"

  create_table "contacts_infos", force: true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "email"
    t.string   "phone_one"
    t.string   "phone_two"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_three"
    t.string   "skype"
    t.string   "facebook"
    t.string   "vk"
    t.string   "google"
    t.string   "youtube"
    t.string   "twitter"
  end

  create_table "filter_joins", force: true do |t|
    t.integer  "tour_id"
    t.integer  "filter_word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filter_word_translations", force: true do |t|
    t.integer  "filter_word_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "description"
  end

  add_index "filter_word_translations", ["filter_word_id"], name: "index_filter_word_translations_on_filter_word_id"
  add_index "filter_word_translations", ["locale"], name: "index_filter_word_translations_on_locale"

  create_table "filter_words", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "index_banner_translations", force: true do |t|
    t.integer  "index_banner_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.string   "link"
    t.string   "slug"
    t.string   "date_from"
    t.string   "name_text"
    t.string   "where_to_go"
  end

  add_index "index_banner_translations", ["index_banner_id"], name: "index_index_banner_translations_on_index_banner_id"
  add_index "index_banner_translations", ["locale"], name: "index_index_banner_translations_on_locale"

  create_table "index_banners", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "link"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "published"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personnel_translations", force: true do |t|
    t.integer  "personnel_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "work"
  end

  add_index "personnel_translations", ["locale"], name: "index_personnel_translations_on_locale"
  add_index "personnel_translations", ["personnel_id"], name: "index_personnel_translations_on_personnel_id"

  create_table "personnels", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "work"
    t.string   "phone_number"
    t.string   "email"
    t.integer  "position"
    t.boolean  "published"
    t.integer  "personnel_id"
    t.string   "personnel_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_galleries", force: true do |t|
    t.string   "title"
    t.string   "alt"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_gallery_translations", force: true do |t|
    t.integer  "photo_gallery_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "alt"
  end

  add_index "photo_gallery_translations", ["locale"], name: "index_photo_gallery_translations_on_locale"
  add_index "photo_gallery_translations", ["photo_gallery_id"], name: "index_photo_gallery_translations_on_photo_gallery_id"

  create_table "publication_translations", force: true do |t|
    t.integer  "publication_id",    null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "short_description"
    t.text     "description"
  end

  add_index "publication_translations", ["locale"], name: "index_publication_translations_on_locale"
  add_index "publication_translations", ["publication_id"], name: "index_publication_translations_on_publication_id"

  create_table "publications", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "short_description"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "banner_image_file_name"
    t.string   "banner_image_content_type"
    t.integer  "banner_image_file_size"
    t.datetime "banner_image_updated_at"
    t.boolean  "banner"
    t.boolean  "published"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regulation_translations", force: true do |t|
    t.integer  "regulation_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "page"
  end

  add_index "regulation_translations", ["locale"], name: "index_regulation_translations_on_locale"
  add_index "regulation_translations", ["regulation_id"], name: "index_regulation_translations_on_regulation_id"

  create_table "regulations", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "page"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_translations", force: true do |t|
    t.integer  "service_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "page"
  end

  add_index "service_translations", ["locale"], name: "index_service_translations_on_locale"
  add_index "service_translations", ["service_id"], name: "index_service_translations_on_service_id"

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "page"
    t.boolean  "published"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tour_translations", force: true do |t|
    t.integer  "tour_id",           null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.text     "short_description"
    t.string   "city"
    t.string   "string_price"
  end

  add_index "tour_translations", ["locale"], name: "index_tour_translations_on_locale"
  add_index "tour_translations", ["tour_id"], name: "index_tour_translations_on_tour_id"

  create_table "tours", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "short_description"
    t.text     "description"
    t.float    "price"
    t.string   "city"
    t.datetime "date_begin"
    t.datetime "date_end"
    t.integer  "category_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.string   "locale"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

  create_table "work_region_translations", force: true do |t|
    t.integer  "work_region_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
  end

  add_index "work_region_translations", ["locale"], name: "index_work_region_translations_on_locale"
  add_index "work_region_translations", ["work_region_id"], name: "index_work_region_translations_on_work_region_id"

  create_table "work_regions", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
