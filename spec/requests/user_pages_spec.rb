require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
   	let(:submit) { "Zarejestruj"}

    it { should have_selector('h1',    text: 'Rejestracja') }
    it { should have_selector('title', text: 'Rejestracja') }

    describe "with invalid information" do
    	it "should not create a user" do
    		expect { click_button submit }.not_to change(User, :count)
    	end
    end

    describe "with valid information" do
    	before do 
    		fill_in "Imie", 	with: "Mateusz"
    		fill_in "Nazwisko", 	with: "Wilcz"
    		fill_in "Email", 	with: "user@example.com"
    		fill_in "Has",     with: "foobar"
        	fill_in "Potwie", with: "foobar"
    	end
    	it "should create a user" do
    		expect { click_button submit }.to change(User, :count).by(1)
    	end
      describe "after saving user" do
        before do 
        fill_in "Imie",   with: "Mateusz"
        fill_in "Nazwisko",   with: "Wilcz"
        fill_in "Email",  with: "user@example.com"
        fill_in "Has",     with: "foobar"
          fill_in "Potwie", with: "foobar"
          click_button submit
      end
        it { should have_link('Wyloguj') }
      end
    end
  end

  describe "profile page" do 
  	let(:user) { FactoryGirl.create(:user) }
  	before {visit user_path(user) }

  	it { should have_selector('h1',    text: user.forename) }
  	it { should have_selector('title', text: user.forename) }
  	it { should have_selector('h1',    text: user.surname) }
  	it { should have_selector('title', text: user.surname) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do 
      it { should have_selector('h1', text: "Edytuj profil")}
      it { should have_selector('title'), text:"Edycja profilu"}
    end 

    describe "with invalid information" do
      before { click_button "Zapisz zmiany"}

      it { should have_content('error')}
    end

    describe "with valid information" do
      let(:new_fname) { "New Fname"}
      let(:new_sname) { "New Sname"}
      let(:new_email) { "new@ne.pl"}
      before do
        fill_in "Imi", with:new_fname
        fill_in "Nazwisko", with:new_sname
        fill_in "Email", with:new_email
        fill_in "Has", with: user.password
        fill_in "Potwie", with: user.password
        click_button "Zapisz zmiany"
      end

      it { should have_selector('title', text: new_fname) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Wyloguj', href: signout_path) }
      specify { user.reload.forename.should  == new_fname }
      specify { user.reload.email.should == new_email }
    end
  end
end