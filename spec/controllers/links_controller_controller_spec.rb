require 'rails_helper'

RSpec.describe LinksControllerController, type: :controller do

  describe "GET #download" do
    it "returns http success" do
      get :download
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #download_attachment" do
    it "returns http success" do
      get :download_attachment
      expect(response).to have_http_status(:success)
    end
  end

end
