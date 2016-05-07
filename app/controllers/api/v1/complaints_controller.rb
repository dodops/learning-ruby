class Api::V1::ComplaintsController < ApiController
  #before_action :authenticate_with_token!

  def show
    render json: Complaint.find(params[:id])
  end

  def index
    render json: Complaint.all
  end

  def search
    complaints = Complaint
                    .joins("JOIN cities ON cities.id = complaints.city_id JOIN states ON states.id = complaints.state_id")
                    .where("address LIKE '%#{params[:address]}%' AND cities.name LIKE '%#{params[:city]}%' AND states.name LIKE '%#{params[:state]}%'")
    render json: complaints
  end
end
