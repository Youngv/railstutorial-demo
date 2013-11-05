require 'spec_helper'

describe "Static Pages" do
  subject{page}

  shared_examples_for "all Static pages" do
    it{should have_content(heading)}
    it{should have_title(full_title(page_title))}
  end

  describe "Home Page" do
    before{visit root_path}
    let(:heading) { 'Demo' }
    let(:page_title) { '' }  
    it_should_behave_like "all Static pages"
    it{should_not have_title(full_title("| Home"))}
  end

  describe "Help Page" do
    before{visit help_path}
    let(:heading) { 'Help' } 
    let(:page_title) { 'Help' }
  end

  describe "About Page" do
    before{visit about_path}
    let(:heading) { 'About Us' }
    let(:page_title) { 'About Us' }  
  end

  describe "Contact Page" do
    before{visit contact_path}
    let(:page_title) { 'Contact' } 
    it{should have_selector('h1', text:'Contact')}
  end

  it "should have the right links on the layout" do 
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    expect(page).to have_title(full_title(''))
    click_link "Sign Up Now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "Demo"
    expect(page).to have_title(full_title(''))
  end
end
