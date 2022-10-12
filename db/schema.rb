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

ActiveRecord::Schema.define(version: 2022_10_12_192815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "bookmaker_id", null: false
    t.decimal "balance", default: "0.0", null: false
    t.string "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookmaker_id"], name: "index_accounts_on_bookmaker_id"
    t.index ["number"], name: "index_accounts_on_number", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "result", default: "pending", null: false
    t.decimal "amount", null: false
    t.decimal "winning_amount", default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_bets_on_event_id"
  end

  create_table "bookmakers", force: :cascade do |t|
    t.string "name", null: false
    t.string "country", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "country_tax_percentage", default: "0.0", null: false
    t.index ["name"], name: "index_bookmakers_on_name", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "team_id"
    t.float "odds", null: false
    t.string "eventable_type", null: false
    t.bigint "eventable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["eventable_type", "eventable_id"], name: "index_events_on_eventable"
    t.index ["game_id"], name: "index_events_on_game_id"
    t.index ["team_id"], name: "index_events_on_team_id"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.bigint "season_id", null: false
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.bigint "winner_id"
    t.string "gameable_type", null: false
    t.bigint "gameable_id", null: false
    t.datetime "date", null: false
    t.string "link"
    t.string "api_id"
    t.string "score"
    t.boolean "extra_time", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["away_team_id"], name: "index_games_on_away_team_id"
    t.index ["date", "away_team_id", "home_team_id"], name: "idx_teams_date_uniq", unique: true
    t.index ["gameable_type", "gameable_id"], name: "index_games_on_gameable"
    t.index ["home_team_id"], name: "index_games_on_home_team_id"
    t.index ["league_id"], name: "index_games_on_league_id"
    t.index ["season_id"], name: "index_games_on_season_id"
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "handicaps", force: :cascade do |t|
    t.float "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "individual_totals", force: :cascade do |t|
    t.float "value", null: false
    t.string "condition", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "match_winners", force: :cascade do |t|
    t.boolean "with_extra_time", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "operations", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.string "operational_type", null: false
    t.bigint "operational_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_operations_on_account_id"
    t.index ["operational_type", "operational_id"], name: "index_operations_on_operational"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "playoffs", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["season_id"], name: "index_playoffs_on_season_id"
  end

  create_table "regular_seasons", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["season_id", "start_date", "end_date"], name: "idx_regular_seasons_date_uniq", unique: true
    t.index ["season_id"], name: "index_regular_seasons_on_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.string "year", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["league_id"], name: "index_seasons_on_league_id"
    t.index ["year", "league_id"], name: "index_seasons_on_year_and_league_id", unique: true
  end

  create_table "statistics", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "statisticable_type", null: false
    t.bigint "statisticable_id", null: false
    t.float "x_goals"
    t.float "x_goals_against"
    t.float "power_play"
    t.float "penalty_kill"
    t.float "save_percentage"
    t.float "goals_saved_about_expected"
    t.index ["game_id", "statisticable_id"], name: "index_statistics_on_game_id_and_statisticable_id", unique: true
    t.index ["statisticable_type", "statisticable_id"], name: "index_statistics_on_statisticable"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.string "name", null: false
    t.string "abbreviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["league_id"], name: "index_teams_on_league_id"
    t.index ["name", "abbreviation"], name: "index_teams_on_name_and_abbreviation", unique: true
  end

  create_table "totals", force: :cascade do |t|
    t.float "value", null: false
    t.string "condition", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.string "result", null: false
    t.decimal "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "mobile_phone", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mobile_phone"], name: "index_users_on_mobile_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "bookmakers"
  add_foreign_key "accounts", "users"
  add_foreign_key "bets", "events"
  add_foreign_key "events", "games"
  add_foreign_key "events", "teams"
  add_foreign_key "games", "leagues"
  add_foreign_key "games", "seasons"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "games", "teams", column: "winner_id"
  add_foreign_key "operations", "accounts"
  add_foreign_key "operations", "users"
  add_foreign_key "playoffs", "seasons"
  add_foreign_key "regular_seasons", "seasons"
  add_foreign_key "seasons", "leagues"
  add_foreign_key "statistics", "games"
  add_foreign_key "teams", "leagues"
end
