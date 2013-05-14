class CartController < ApplicationController
	def create
		@product = Product.find(params[:cart][:product_id])
    	current_user.follow!(@user)
   		
	end
end
