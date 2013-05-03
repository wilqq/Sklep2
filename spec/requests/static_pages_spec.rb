require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'Sklep'" do
      visit '/static_pages/home'
      page.should have_content('Sklep')
    end
  end
  describe "Help" do
  	it "should have the content Pomoc" do
  		visit help_path
  		page.should have_content ('Pomoc')
  	end
  	it "should have title '| Pomoc'" do
  		visit help_path
  		page.should have_sellector( :title => 'Pomoc')
  	end
  end
end