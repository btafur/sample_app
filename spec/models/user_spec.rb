# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "Example User", :email =>"user@example.com"}
  end
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
	no_name_user.should_not be_valid
  end
  it "should require an email address" do
    no_name_user = User.new(@attr.merge(:email => ""))
	no_name_user.should_not be_valid
  end
  
  it "reject names that are too long" do
    long = "a"*51
	user = User.new(@attr.merge(:name => long))
	user.should_not be_valid
  end
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_user@foo.bar.org first.last@foo.jp]
	addresses.each do |address|
	  valid_email_user = User.new(@attr.merge(:email => address))
	  valid_email_user.should be_valid
	end
  end
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com THE_user_foo.bar.org first.last@foo.]
	addresses.each do |address|
	  valid_email_user = User.new(@attr.merge(:email => address))
	  valid_email_user.should_not be_valid
	end
  end
  it "should reject duplicate email addresses" do
    User.create!(@attr)
	user_with_duplicate_email = User.new(@attr)
	user_with_duplicate_email.should_not be_valid
  end
  it "should reject email addresses identical up to case" do
    User.create!(@attr)
	user_with_duplicate_email = User.new(@attr.merge(:email => "USER@EXAMPLE.COM"))
	user_with_duplicate_email.should_not be_valid
  end
end
