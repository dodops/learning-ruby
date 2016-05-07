class ComplaintSerializer < ActiveModel::Serializer
  attributes :address, :cep
  has_one :city
  has_one :state
end
