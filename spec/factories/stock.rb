
FactoryBot.define do
    factory :stock do
      symbol "TEST"
      sector "test sector"
      current_price 0
      year_low 0
      created_at "2017-12-16 02:39:50"
      updated_at "2017-12-16 02:39:50"
    end
  end

  #t.string "symbol"
  #t.string "sector"
  #t.decimal "current_price"
  #t.decimal "year_low"
  #t.datetime "created_at", null: false
  #t.datetime "updated_at", null: false