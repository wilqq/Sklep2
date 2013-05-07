require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
      before {visit root_path}
      it { should have_content('Sklep') }

  end
  describe "Help" do
  		before {visit help_path}
		  it {should have_content ('Pomoc')}
  		it {should have_selector( 'title',  text: 'Pomoc')} 
  end
end