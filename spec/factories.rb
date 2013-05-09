FactoryGirl.define do 
	factory :user do 
		forename	"Mat"
		surname		"Wilcz"
		email    	"michael@example.com"
    	password 	"foobar"
    	password_confirmation "foobar"
	end
end