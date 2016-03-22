require 'rails_helper'

describe ComplaintsController do
  login_user

  let(:city) { create(:city) }

  describe "GET #index" do
    let(:complaint_zika) { create :complaint, city_id: city.id, state_id: city.state.id }

    it "renders :index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assings @complaints" do
      get :index
      expect(assigns(:complaints)).to eq([complaint_zika])
    end
  end


  describe "GET #show" do
    let(:complaint_zika) { create :complaint, city_id: city.id, state_id: city.state.id }

    it "renders :show template" do
      get :show, id: complaint_zika
      expect(response).to render_template(:show)
    end

    it "assings @complaint" do
      get :show, id: complaint_zika
      expect(assigns(:complaint)).to eq complaint_zika
    end
  end


  describe "GET #new" do
    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "loads @states" do
      state = create(:state)
      get :new
      expect(assigns(:states)).to include(state)
    end
  end


  describe "GET #edit" do
    let(:complaint_zika) { create :complaint, city_id: city.id, state_id: city.state.id }

    it "renders :edit template" do
      get :edit, id: complaint_zika
      expect(response).to render_template(:edit)
    end

    it "assigns @complaint" do
      get :edit, id: complaint_zika
      expect(assigns(:complaint)).to eq complaint_zika
    end
  end


  describe "POST #create" do

    context "with valid attributes" do

      it "create a new complaint" do
        expect {
          post :create, complaint: attributes_for(:complaint, city_id: city.id, state_id: city.state.id)
        }.to change(Complaint, :count).by(1)
      end

      it "will redirect to :show complaint" do
        post :create, complaint: attributes_for(:complaint, city_id: city.id, state_id: city.state.id)
        expect(response).to redirect_to(assigns(:complaint))
      end

      it "return successful message" do
        post :create, complaint: attributes_for(:complaint, city_id: city.id, state_id: city.state.id)
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do

      it "doesn't create a new complaint" do
        expect {
          post :create, complaint: attributes_for(:complaint, address: '', city_id: city.id, state_id: city.state.id)
        }.to_not change(Complaint, :count)
      end

      it "will render :new template" do
        post :create, complaint: attributes_for(:complaint, address: '', city_id: city.id, state_id: city.state.id)
        expect(response).to render_template(:new)
      end

      it "doesn't return successful message" do
        post :create, complaint: attributes_for(:complaint, address: '', city_id: city.id, state_id: city.state.id)
        expect(flash[:notice]).to_not be_present
      end
    end
  end


  describe "PATCH #update" do
    let(:complaint_zika) { create :complaint, city_id: city.id, state_id: city.state.id }

    context "with valid attributes" do

      it "update complaint" do
        patch :update, id: complaint_zika.id, complaint: attributes_for(:complaint, address: 'New address')
        complaint_zika.reload
        expect(assigns(:complaint)).to eq complaint_zika
      end

      it "will redirect to :show complaint" do
        patch :update, id: complaint_zika.id, complaint: attributes_for(:complaint, address: 'New address')
        expect(response).to redirect_to(assigns(:complaint))
      end

      it "return successful message" do
        patch :update, id: complaint_zika.id, complaint: attributes_for(:complaint, address: 'New address')
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do

      it "doesn't update complaint" do
        patch :update, id: complaint_zika.id, complaint: attributes_for(:complaint, address: nil)
        expect(assigns(:complaint).errors).to be_present
      end

      it "will render :edit template" do
        patch :update, id: complaint_zika.id, complaint: attributes_for(:complaint, address: nil)
        expect(response).to render_template(:edit)
      end

      it "doesn't return successful message" do
        patch :update, id: complaint_zika.id, complaint: attributes_for(:complaint, address: nil)
        expect(flash[:notice]).to_not be_present
      end
    end
  end


  describe "DELETE #destroy" do
    let!(:complaint_zika) { create :complaint, city_id: city.id, state_id: city.state.id }

    it "deletes the complaint" do
      expect {
        delete :destroy, id: complaint_zika.id
      }.to change(Complaint, :count).by(-1)
    end
  end

end

