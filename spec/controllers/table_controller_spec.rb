require 'rails_helper'
require './spec/controller_macros.rb'


RSpec.describe TableController do
    describe "Get index" do
        it "renders :index template" do
            get :index
            expect(response).to render_template(:index)
        end
        
    end

    describe "GET show" do
        let(:table) { FactoryBot.create(:table)}
  
        it "renders :show template" do
          get :show, params: {id: table.id }
          expect(response).to render_template(:show)
        end
  
        it "assigns requested table to @table" do
          get :show, params: {id: table.id }
          expect(assigns(:table)).to eq(table)
        end
    end

    describe "DELETE destroy" do
        login_user
        let(:table) { FactoryBot.create(:table)}
    
        it "redirects to table#index" do  
            delete :destroy, params: {id: table.id }
            expect(response).to redirect_to(home_path)
        end

        it "deletes table from database" do
        
          delete :destroy, params: {id: table.id }
          expect(Table.exists?(table.id)).to be_falsy
        end
    end
  
      describe "POST create" do
        login_user
        let(:valid_data) { FactoryBot.attributes_for(:table) }
  
        context "valid data" do
          it "redirects to table#show" do
            post :create, params: {table: valid_data}
            expect(response).to redirect_to(home_path)
          end
          it "creates new table in database" do
            expect {
              post :create, params: {table: valid_data}
            }.to change(Table, :count).by(1)
          end
        end
  
        context "invalid data" do
          let(:invalid_data) { FactoryBot.attributes_for(:table, symbol: '') }
  
          it "doesn't create new table in the database" do
            expect {
              post :create, params: {table: invalid_data}
            }.not_to change(Table, :count)
          end
        end
      end
end