require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "signin page" do 
  	before { visit signin_path }

  	it { should have_selector('h1', text: 'Logowanie')}
  	it { should have_selector('title', text: 'Logowanie')}

  	describe "with invalid information" do
  		before { click_button "Zaloguj"}

  		it { should have_selector('title', text: 'Logowanie') }
      it { should have_selector('div.alert.alert-error', text: 'Niepoprawny') }
  	end

  	describe "with valid information" do 
  		let(:user) {FactoryGirl.create(:user)}
  		before do 
  			fill_in "Email", with: user.email.upcase
  			fill_in "Has", with: user.password
  			click_button "Zaloguj"
  		end

  		it { should have_selector('title', text: user.forename) }
     	it { should have_link('Profil', href: user_path(user)) }
      	it { should have_link('Wyloguj', href: signout_path) }
      	it { should_not have_link('Logowanie', href: signin_path) }
  	end
  end
end
