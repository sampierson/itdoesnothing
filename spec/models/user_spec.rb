require 'spec_helper'

describe User do

  it { should serialize_attribute(:roles) }

  describe "defaults" do
    it "should default roles to [user]" do
      subject.valid?
      subject.roles.should == ['user']
    end
  end

  describe "validations" do
    describe "roles" do
      it "should validate it is an array" do
        user = Factory.create(:unconfirmed_user)
        user.roles = "roles must be an array not a string"
        user.valid?
        user.errors_on(:roles).should == ["must be an array"]
      end

      it "should validate it only contains valid roles" do
        user = Factory.build(:unconfirmed_user)
        user.roles = %w{ user admin developer }
        user.should be_valid
        user.roles = %w{ admin foxtrot barbecue }
        user.errors_on(:roles).should == [ "invalid role: foxtrot", "invalid role: barbecue" ]
      end
    end
  end

  describe "predicate methods for roles" do
    User::ROLES.each do |actual_role|
      User::ROLES.each do |test_for_role|
        expected_result = (test_for_role == actual_role)
        it "should return #{expected_result} for #{test_for_role}? when the user has only role #{actual_role}" do
          user = User.new
          user.roles = [actual_role]
          user.send("#{test_for_role}?".to_sym).should == expected_result
        end
      end
    end
  end
end
