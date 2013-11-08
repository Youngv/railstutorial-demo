require 'spec_helper'

describe User do
	before{@user = User.new(:name => "ExampleUser", 
													:email => "user@example.com", 
													:password => "123456", 
													:password_confirmation => "123456")}
	subject{ @user }
	it {should respond_to(:name)} 
	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:authenticate)}
	it {should respond_to(:remember_token)}

	it {should be_valid}

	describe "when name is empty" do
		before{@user.name = ""}
		it {should_not be_valid}
	end 

	describe "when email is empty" do
		before{@user.email = ""}
		it {should_not be_valid}
	end

	describe "when name length over 50" do
	  before{@user.name = "a" * 51}
	  it{should_not be_valid}
	end

	describe "when email is invalid" do
		it "should be invalid" do
			address = ["djf", "sofaoi@fdof", "fjdslfj@fjsl"]
			address.each do |add|
				@user.email = add
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email is valid" do
		it "should be valid" do
			address = ["1+23.f-da.fs_d@qq.COM", "sofaoif.d@123.org", "fjdslfj@fjsl.me"]
			address.each do |add|
				@user.email = add
				expect(@user).to be_valid
			end
		end
	end

	describe "when email is already token" do
		before do
		  user_with_same_email = @user.dup
		  user_with_same_email.email = @user.email.upcase
		  user_with_same_email.save
		end
		it{should_not be_valid}
	end

	describe "when password is empty" do
	  before do
	  	@user.password = ""
	  	@user.password_confirmation = ""
	  end
	  subject{@user}
	  it{should_not be_valid}
	end

	describe "when password is not same as confirmation" do
	  before{@user.password_confirmation = "123456789"}
	  subject{@user}
	  it{should_not be_valid}
	end

	describe "return value of authenticate method" do
		before{@user.save}
		let(:found_user) {User.find_by(email:@user.email)}

		describe "with valid password" do
			it{should eq found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do
		  let(:user_for_invalid_password) { found_user.authenticate("654321") }
		  it{should_not eq user_for_invalid_password}
		  specify{expect(user_for_invalid_password).to be_false} 
		end
	end

	describe "with short password" do
		before do
			@user.password = "12345"
			@user.password_confirmation = "12345"
		end
		it{should_not be_valid}
	end

	describe "email into downcase before save" do
		before{@user.email = "USER@EXAMPLE.COM"}
		before{@user.save}
		let(:found_user) {User.find_by(email:@user.email.downcase)}
		it{should eq found_user}
	end

	describe "remember token" do
		before{@user.save}
		its(:remember_token) {should_not be_blank}
	end
end
