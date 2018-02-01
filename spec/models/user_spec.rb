require 'rails_helper'

RSpec.describe User, type: :model do
 


 subject { described_class.new(name: "myname", password: "test_password", email: "user1@example.com") }

  describe "Validations" do
	    it "is valid with valid attributes" do
	      expect(subject).to be_valid
	    end

	    it "is not valid without a password" do
	      subject.password = nil
	      expect(subject).to_not be_valid
	    end

	    it "is not valid without an email" do
	      subject.email = nil
	      expect(subject).to_not be_valid
	    end

	    it { should validate_uniqueness_of(:email) }
  end



  describe "Associations" do
    it { should have_many(:listings) }
    it { should have_many(:comments) }
    it { should have_many(:authentications) }
  end



  describe "Listing count" do
    it "should return number of listing for the user" do
      user = User.new(name: "myname", password: "test_password", email: "user1@example.com")
      user.save
      listing = Listing.new(title: "Who Moved My Cheese", user_id: user.id)
      listing.save
      expect(user.listing_count).to eq(1)
    end
  end



  describe "Generate fb token" do
    it "should return fb token if authentication exists" do
      user = User.new(name: "myname", password: "test_password", email: "user1@example.com")
      user.save
      authentication = Authentication.new(uid: "some_uid", provider: "facebook", token: "12345", user_id: user.id)
      authentication.save
      expect(user.fb_token).to eq("12345")
    end

    it "should not return fb token if authentication is not exist" do
      user = User.new(name: "myname", password: "test_password", email: "user1@example.com")
      user.save
      authentication = Authentication.new(uid: "some_uid", provider: "google", token: "12345", user_id: user.id)
      authentication.save
      expect(user.fb_token).to be_nil
	end
  end

  



end
