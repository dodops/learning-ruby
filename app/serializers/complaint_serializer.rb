class ComplaintSerializer < ActiveModel::Serializer
  attributes :id, :address, :cep
  has_one :state, :city
end
