class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  # GET /products
  # GET /products.json


  # [2] Added search action to controller |cc|
  def index
    @products = Product.search(params[:search])
  end
  # [2] End |cc|


  # GET /products/1
  # GET /products/1.json
  def show
    @review = Review.new
  end


  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        # [6] Interpolated instance var so that name shows up in message |cc|
        format.html { redirect_to @product, notice: "#{@product} was successfully updated." }
        # [6] End |cc|
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json


  def destroy
    @product.destroy
    respond_to do |format|
      # [6] Changed 'Destroy' to 'Remove' + changed index view |cc|
      # [6] Interpolated instance var so that name shows up in message |cc|
      format.html { redirect_to products_url, notice: "#{@product} was successfully removed." }
      # [6] End |cc|
      format.json { head :no_content }
    end
  end
  

  def barcode
    require 'unirest'
    upc = params[:barcode]

    response = Unirest.get "https://community-outpan.p.mashape.com/get_product.php?barcode=#{upc}",
         
    headers:{
          "X-Mashape-Key" => "L90l5rQA7smshIUnQLnW4YYUc3kzp1VZhEZjsnUq2OaaQJwhol"}
      format.json { head response.body }
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      #params.require(:product).permit(:name, :description, :price_in_cents, :details, :avatar)
      params[:product][:price_in_cents] = params[:product][:price_in_cents].to_f * 100
      params.require(:product).permit(:name, :description, :price_in_cents, :details, :avatar)
    end



end
