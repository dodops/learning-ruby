class Api::V1::ComplaintsController < ApiController
  def show
    render json: Complaint.find(params[:id])
  end

  def index
    render json: { complaints: Complaint.all }
  end
end
