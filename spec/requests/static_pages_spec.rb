require 'spec_helper'

describe "Static Pages" do
	let(:title_base) { "Ruby on Rails Tutorial Demo" }
  describe "Home Page" do
    it "should have the content 'Demo'" do
      visit '/static_pages/home'
      expect(page).to have_content('Demo')
    end

    it "should have the right title" do 
    	visit '/static_pages/home'
    	expect(page).to have_title("#{title_base} | Home")
    end
  end

  describe "Help Page" do
  	it "should have the content 'Help" do
  		visit '/static_pages/help'
  		expect(page).to have_content('Help')
  	end

    it "should have the right title" do 
    	visit '/static_pages/help'
    	expect(page).to have_title("#{title_base} | Help")
    end
  end

  describe "About Page" do
  	it "should have the content 'About Us'" do
  		visit '/static_pages/about'
  		expect(page).to have_content('About Us')
  	end

    it "should have the right title" do 
    	visit '/static_pages/about'
    	expect(page).to have_title("#{title_base} | About Us")
    end 
  end

  describe "Contact Page" do
    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end

    it "should have the right title" do
    	visit '/static_pages/contact'
    	expect(page).to have_title("#{title_base} | Contact")
    end
  end
end
