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
            redirect_to home_path(@table)
            else
                render 'new'
            end
    end

    def edit
        
    end

    def update
        @table = Table.find(params[:id])
        if(@table.update(table_params))
            redirect_to @table
        else
            render 'index'
        end
    
    end

    def destroy
       @table = Table.find(params[:id]).destroy
        redirect_to home_path

    end

    private def table_params
        params.require(:table).permit(:symbol, :shares, :buy_price, :current_price)
    end

end
