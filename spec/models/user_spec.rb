require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value("example@domain.com").for(:email) }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to respond_to(:auth_token) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      user = create(:user)
      expect(user.auth_token).to_not be_nil
    end
  end

end
