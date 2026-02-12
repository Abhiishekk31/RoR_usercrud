class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @products = Product.all
    render json: { message: "Products retrieved successfully", data: @products }
  end

  def show
    @product = Product.find(params[:id])
    render json: { message: "Products retrieved successfully", data: @product }
  end

  def new
    @product = Product.new
    render json: { message: "Products retrieved successfully", data: @product }
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: {
        message: "Product created successfully",
        data: @product
      }, status: :created
    else
      render json: {
        message: "Product failed to create",
        errors: @product.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    render json: { message: "Products retrieved successfully", data: @product }
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: {
        message: "Product updated successfully",
        data: @product
      }, status: :ok
    else
      render json: {
        message: "Product failed to update",
        errors: @product.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    render json: { message: "Product deleted successfully" }, status: :ok
  end

  private
    def product_params
      params.expect(product: [ :name ])
    end
end
