require 'rails_helper'

RSpec.describe Api::V1::ComplaintsController, type: :controller do
  describe "GET #show" do

    context "with an user logged" do
      let(:complaint) { create(:complaint) }
      let(:user) { create(:user) }

      before do
        api_token(user.auth_token)
        get :show, id: complaint
      end

      it "returns the information about a complaint on a hash" do
        complaint_response = json_response[:complaint]
        expect(complaint_response[:address]).to eq complaint.address
      end

      it { expect(response).to have_http_status(:success) }
    end

    context "without an user logged." do
      let(:complaint) { create(:complaint) }

      it "should respond with unauthorized code " do
        get :show, id: complaint
        expect(response).to have_http_status(:unauthorized)
      end
    end

  end

  describe "GET #index" do
    let(:user) { create(:user) }
    let!(:complaints) { create_list :complaint, 4 }

    context "with an user logged" do

      before do
        api_token(user.auth_token)
        get :index
      end

      it "returns 4 records from the database" do
        complaint_response = json_response
        expect(complaint_response[:complaints]).to have(4).items
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'without an user logged' do
      before { get :index }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  # describe "GET #search" do
  #   let!(:complaint) { create_list(:complaint, 3) }

  #   it "returns a array of results" do
  #     get :search, {""}
end
