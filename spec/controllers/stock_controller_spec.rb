require 'rails_helper'

RSpec.describe StockController do
    describe "Get index" do
        it "renders :index template" do
            get :index
            expect(response).to render_template(:index)
        end
        
    end

    describe "GET show" do
        let(:stock) { FactoryBot.create(:stock)}
  
        it "renders :show template" do
          get :show, params: {id: stock.id }
          expect(response).to render_template(:show)
        end
  
        it "assigns requested stock to @stock" do
          get :show, params: {id: stock.id }
          expect(assigns(:stock)).to eq(stock)
        end
    end

    describe "DELETE destroy" do
        let(:stock) { FactoryBot.create(:stock)}

        it "redirects to stock#index" do
          delete :destroy, params: {id: stock.id }
          expect(response).to redirect_to(home_path)
        end

        it "deletes stock from database" do
          delete :destroy, params: {id: stock.id }
          expect(Stock.exists?(stock.id)).to be_falsy
        end
    end
  
      describe "POST create" do
        let(:valid_data) { FactoryBot.attributes_for(:stock) }
  
        context "valid data" do
          it "redirects to stock#show" do
            post :create, params: {stock: valid_data}
            expect(response).to redirect_to(home_path)
          end
          it "creates new stock in database" do
            expect {
              post :create, params: {stock: valid_data}
            }.to change(Stock, :count).by(1)
          end
        end
  
        context "invalid data" do
          let(:invalid_data) { FactoryBot.attributes_for(:stock, symbol: '') }
  
          it "doesn't create new stock in the database" do
            expect {
              post :create, params: {stock: invalid_data}
            }.not_to change(Stock, :count)
          end
        end
      end
end