class Table < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    validates :symbol, presence: true
    #validates :symbol, uniqueness:true

    def test_query

    end
end
