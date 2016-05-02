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
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      subject.generate_authentication_token!
      expect(subject.auth_token).to eq "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = create(:user, auth_token: 'auniquetoken123')
      subject.generate_authentication_token!
      expect(subject.auth_token).to_not eq existing_user.auth_token
    end
  end

end
