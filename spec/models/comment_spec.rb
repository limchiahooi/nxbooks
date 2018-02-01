require 'rails_helper'

RSpec.describe Comment, type: :model do


	subject { described_class.new(content: "I love this book!") }

  	describe "Validations" do
	    it "is not valid without a content" do
	      subject.content = nil
	      expect(subject).to_not be_valid
	    end
	end

	describe "Associations" do
		it { should belong_to(:user) }
		it { should belong_to(:listing) }
	end
  
end
