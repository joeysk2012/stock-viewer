

FactoryBot.define do
    factory :table do
      symbol "TEST"
      shares 100
      buy_price 10
      current_price 10
      created_at "2017-12-16 02:39:50"
      updated_at "2017-12-16 02:39:50"
      user
    end
  end


    #"shares"
    # "symbol"
    # "buy_price"
    # "current_price"
    #"created_at", null: false
    # "updated_at", null: false
    # "user_id"
