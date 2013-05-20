class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def new
    @cart = current_cart
  	@user = User.new
  end

  def show
    @cart = current_cart
  	@user = User.find(params[:id])
  end

  def create
    @cart = current_cart
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Witamy w najlepszym sklepie"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @cart = current_cart
    @user = User.find(params[:id])
  end

  def update
    @cart = current_cart
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Zaktualizowano profil"
      sign_in @user
      redirect_to  @user
    else
      render 'edit'
    end    
  end

  private

  def signed_in_user
    unless  signed_in?
      store_location
      redirect_to signin_url, notice: "Zaloguj sie" 
    end    
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
