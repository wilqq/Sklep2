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
        it { should have_link('Ustawienia', href: edit_user_path(user)) }
  	end
  end

  describe "authorization" do 
    describe "for non-signed-in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Has", with: user.password
          click_button "Zaloguj"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edycja')
          end
        end
      end

      describe "in the Users controller" do 

        describe "visiting the edit page" do

          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Logowanie')}
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user){ FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@inte.pl")}
      before {sign_in user}

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: 'Edit user') }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end 
  end
end
