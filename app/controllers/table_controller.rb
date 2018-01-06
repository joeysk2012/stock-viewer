require 'net/http'
require 'json'
require './app/assets/logic/updateStatement'


class TableController < ApplicationController  
    before_action :authenticate_user!, except: [:index,:show]

    def index
        @table = Table.all
        updateCurrentPrice(@table)
        
    end

    def show
        @table = Table.find(params[:id])
    end


    def new 
        @table = current_user.table.build
    end

    def create
        @table = current_user.table.build(table_params)
        
        if(@table.save)
            current_user.update(money: (current_user.money - (@table.shares * @table.current_price )))
            redirect_to home_path(@table)
            else
                render 'new'
            end
    end

    def edit
        @table = current_user.table.find(params[:id])
    end

    def update
        @table = Table.find(params[:id]) 
        prev_shares = @table.shares
        
        if(@table.update(table_params))
            current_user.update(money: current_user.money + ((prev_shares-@table.shares) * @table.current_price)) 
            redirect_to home_path
        else
            render 'edit'
        end
    
    end

    def destroy
        #current_user.update(money: (current_user.money - (@table.shares * @table.current_price )))
        @table = Table.find(params[:id]).destroy
        redirect_to home_path
    end

    private def table_params
        params.require(:table).permit(:symbol, :shares, :buy_price, :current_price)
    end

end
