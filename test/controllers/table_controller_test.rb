require 'test_helper'

class TableControllerTest < ActionDispatch::IntegrationTest
  describe "GET #new" do
    it "render new template" do
        get :new
        assert_response :success
    end
end
