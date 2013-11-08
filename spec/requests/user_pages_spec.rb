require 'spec_helper'

describe "User pages" do
  subject {page}

  describe "signup page" do
    before {visit signup_path}  
    let(:submit) { "Create my account" }
    
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
	  
	  describe "with invalid information" do
	  	it "should not create a new user" do 
		    expect {click_button submit}.not_to change(User, :count)
		  end

			describe "with the form blank" do
		   	before{click_button submit}
		    it "should show 5 errors" do
		      expect(page).to have_selector('div.alert-error', text:"The form contains 5 errors.")
		    end
		  end
	  end

	  describe "with valid information" do
	    before do
	      fill_in "Name",         with: "Example User"
	      fill_in "Email",        with: "user@example.com"
	      fill_in "Password",     with: "foobar"
	      fill_in "Confirmation", with: "foobar"
	    end

	    it "should create a new user" do
	      expect {click_button submit}.to change(User, :count).by(1)
	    end
	    
	    it "should show the success message" do
	    	click_button submit
	    	expect(page).to have_selector('div.alert.alert-success', text:"Welcome to the Demo!")
	    	expect(page).to have_title(full_title("Example User"))
	    	expect(page).to have_link('Sign out')
	    end
	  end
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) } 
    before {visit user_path(user)}
    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end

  
end