class Stock < ApplicationRecord

    validates :symbol, presence: true
    validates :symbol, uniqueness:true

end
