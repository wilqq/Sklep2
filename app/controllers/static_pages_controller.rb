class StaticPagesController < ApplicationController
  def home
  	@cart = current_cart
  end

  def help
  	@cart = current_cart
  end

  def about
  	@cart = current_cart
  end

  def contact
  	@cart = current_cart
  end
end
