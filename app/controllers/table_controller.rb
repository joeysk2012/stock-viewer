require 'net/http'
require 'json'
 
class TableController < ApplicationController  

    def index
        @table = Table.all
        
    end

    def show
        @table = Table.find(params[:id])
    end


    def new 
        @table = Table.new
        
    end

    def create
        @table = Table.new(table_params)
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
