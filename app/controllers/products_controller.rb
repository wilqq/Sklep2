class ProductsController < ApplicationController
  before_filter :is_admin, only: [:new, :create, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    @cart = current_cart
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @cart = current_cart
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @cart = current_cart
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @cart = current_cart
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @cart = current_cart
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html do
           flash[:success] = 'Dodano produkt' 
          redirect_to @product
       end
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @cart = current_cart
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Zaktualizowano produkt' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @cart = current_cart
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
  def is_admin
    unless current_user.admin?
      flash[:error] = "Nie jestes adminem"
      redirect_to root_path 
    end
  end
end
