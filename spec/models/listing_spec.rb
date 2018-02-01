require 'rails_helper'

RSpec.describe Listing, type: :model do


	subject { described_class.new(title: "Who Moved My Cheese?") }

  	describe "Validations" do
	    it "is not valid without a title" do
	      subject.title = nil
	      expect(subject).to_not be_valid
	    end
	    
	end

	describe "Associations" do
		it { should belong_to(:user) }
		it { should have_many(:comments) }
	end


	describe "Comment count" do
    it "should return number of comment for the listing" do
      user = User.new(name: "myname", password: "test_password", email: "user1@example.com")
      user.save
      listing = Listing.new(title: "Who Moved My Cheese", user_id: user.id)
      listing.save
      comment = Comment.new(content: "I love this book!", user_id: user.id, listing_id: listing.id)
      comment.save
      expect(listing.comment_count).to eq(1)
    end
  end
  
end
