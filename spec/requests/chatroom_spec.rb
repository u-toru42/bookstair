require 'rails_helper'

RSpec.describe "Chatrooms", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/chatroom/show"
      expect(response).to have_http_status(:success)
    end
  end

end
