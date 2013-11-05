require 'spec_helper'

describe "full title" do
  it "should include the page title" do
    expect(full_title('Home')).to match(/Home$/)
  end

  it "should include the base title" do
    expect(full_title('Contact')).to match(/^Ruby on Rails Tutorial Demo/)
  end

  it "should only include the base title" do
    expect(full_title('')).to match(/^Ruby on Rails Tutorial Demo$/)
  end
end