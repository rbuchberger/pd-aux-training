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

ActiveRecord::Schema.define(version: 20_180_324_170_732) do
  create_table 'bulletins', force: :cascade do |t|
    t.text 'title'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_bulletins_on_user_id'
  end

  create_table 'completions', force: :cascade do |t|
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'lesson_id'
    t.index ['lesson_id'], name: 'index_completions_on_lesson_id'
    t.index ['user_id'], name: 'index_completions_on_user_id'
  end

  create_table 'documents', force: :cascade do |t|
    t.string 'file_file_name'
    t.string 'file_content_type'
    t.integer 'file_file_size'
    t.datetime 'file_updated_at'
    t.string 'name'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'lessons', force: :cascade do |t|
    t.text 'title'
    t.text 'description'
    t.boolean 'required?'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'timecards', force: :cascade do |t|
    t.integer 'user_id'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'clock_in'
    t.datetime 'clock_out'
    t.index ['user_id'], name: 'index_timecards_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name', null: false
    t.string 'badge_number', null: false
    t.integer 'role', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.datetime 'deleted_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'videos', force: :cascade do |t|
    t.text 'title'
    t.text 'description'
    t.text 'url'
    t.integer 'custom_start'
    t.integer 'custom_end'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'lesson_id'
    t.index ['lesson_id'], name: 'index_videos_on_lesson_id'
  end
end
