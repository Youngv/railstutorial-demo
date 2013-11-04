require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do
    it "should have the content 'Demo'" do
      visit '/static_pages/home'
      expect(page).to have_content('Demo')
    end

    it "should have the right title" do 
    	visit '/static_pages/home'
    	expect(page).to have_title('Ruby on Rails Tutorial Demo | Home')
    end
  end

  describe "Help Page" do
  	it "should have the content 'Help" do
  		visit '/static_pages/help'
  		expect(page).to have_content('Help')
  	end

    it "should have the right title" do 
    	visit '/static_pages/help'
    	expect(page).to have_title('Ruby on Rails Tutorial Demo | Help')
    end
  end

  describe "About Page" do
  	it "should have the content 'About Us'" do
  		visit '/static_pages/about'
  		expect(page).to have_content('About Us')
  	end

    it "should have the right title" do 
    	visit '/static_pages/about'
    	expect(page).to have_title('Ruby on Rails Tutorial Demo | About Us')
    end 
  end
end
