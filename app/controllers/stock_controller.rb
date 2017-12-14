require './app/assets/logic/updateAllStocks.rb'
require './app/assets/logic/suggestion1.rb'

class StockController < ApplicationController
    def index
        @stock = Stock.all 
    end

    def show
        @stock = Stock.find(params[:id])
    end

    def new 
        @stock = Stock.new
        
    end

    def create
        @stock = Stock.new(stock_params)
        if(@stock.save)
            redirect_to home_path(@stock)
            else
                render 'new'
            end
    end

    def edit
       
    end

    def update
      
    end

    def destroy
       @stock = Stock.find(params[:id]).destroy
        redirect_to home_path
    end

    def renew_all
        @stock = Stock.all
        updateAllStocks(@stock)
        if(@stock.save)
            redirect_to stock_index_path
        else
             redirect_to stock_index_path
        end
    end

    def suggest_buy_low
        @stock = Stock.all
    
    end

    private def stock_params
        params.require(:stock).permit(:symbol, :sector, :current_price, :year_low)
    end




end
