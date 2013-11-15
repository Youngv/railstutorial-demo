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

  describe "edit profile" do
    let(:user) { FactoryGirl.create(:user) }
    before do
    	sign_in user
    	visit edit_user_path(user)
		end

    describe "page" do
    	it {should have_title("Edit user")} 
    	it {should have_content("Update your profile")}
    	it {should have_link('change', href:"http://gravatar.com/emails")} 	
    end

    describe "with invalid information" do
   		before {click_button "Save changes"}
      it {should have_selector("div.alert.alert-error", text:"")}
    end
		
		describe "with valid information" do
 			let(:new_name) { "new_name" }
 			let(:new_email) { "new@example.com" }
 			before do 
 				fill_in "Name", with: new_name
 				fill_in "Email", with: new_email
 				fill_in "Password", with: user.password
 				fill_in "Confirm Password", with: user.password
 				click_button "Save changes"
 			end

 			it {should have_selector("div.alert.alert-success", text:"Update your profile success!")}
 			it {should have_title(new_name)}
 			it {should have_link('Sign out', href:signout_path)}
 			specify {expect(user.reload.name).to eq new_name}
 			specify {expect(user.reload.email).to eq new_email}
    end    
  end

  describe "index" do
   	let(:user) { FactoryGirl.create(:user) }
    before(:each) do
    	sign_in user
    	visit users_path
    end

    it {should have_title("All users")}
    it {should have_content("All users")}

    describe "pagination" do
    	before(:all) { 30.times {FactoryGirl.create(:user)}}
    	after(:all) { User.delete_all }
    	it {should have_selector("div.pagination")}
    	it "should list each user" do
    		User.paginate(page:1).each do |user|
    			expect(page).to have_selector("li", text:user.name)
    		end
    	end	
    end
    
  end
end