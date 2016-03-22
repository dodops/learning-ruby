require 'rails_helper'

RSpec.describe Complaint, type: :model do
  it { is_expected.to belong_to(:state) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:cep) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:city) }
end

