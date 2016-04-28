require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value("example@domain.com").for(:email) }
end
