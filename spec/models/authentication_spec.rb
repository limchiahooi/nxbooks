require 'rails_helper'

RSpec.describe Authentication, type: :model do



	subject { described_class.new(uid: "some_uid", token: "some_token", provider: "some_provider") }

  	describe "Validations" do
	    it "is not valid without a uid" do
	      subject.uid = nil
	      expect(subject).to_not be_valid
	    end

	    it "is not valid without a token" do
	      subject.token = nil
	      expect(subject).to_not be_valid
	    end

	    it "is not valid without a provider" do
	      subject.provider = nil
	      expect(subject).to_not be_valid
	    end	    
	end

	describe "Associations" do
		it { should belong_to(:user) }
	end


  
end
