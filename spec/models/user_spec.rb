require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with password & password_crendtials' do
      @user = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: "password",
        password_confirmation: "password"
      })
      expect(@user).to be_valid
    end
    it 'must be invalid without password or password_crendtials' do
      @user = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: nil,
        password_confirmation: nil
      })
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("can't be blank")
    end
    it "must be invalid if password and password_crendtials don't match" do
      @user = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: "password",
        password_confirmation: "123"
      })
      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "must be invalid if the email has already been taken" do
      @user1 = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: "password",
        password_confirmation: "password"
      })
      @user1.save!
      @user2 = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: "password",
        password_confirmation: "password"
      })
      expect(@user2).to_not be_valid
      expect(@user2.errors[:email]).to include("has already been taken")
    end
    it "must be invalid if password length is less than 5 characters" do
      @user = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: "pass",
        password_confirmation: "pass"
      })
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "must successfully login with proper credentials" do
      @user = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: "password",
        password_confirmation: "password"
      })
      @user.save!
      @user2 = User.authenticate_with_credentials("lenil@email.com", "password")
      expect(@user2).not_to be_nil
    end
  end
end
