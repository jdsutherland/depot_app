class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to @product, notice: 'Product was successfully created.'
        end
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json do
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html do
          redirect_to @product, notice: 'Product was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all
        ActionCable.server.broadcast 'products',
                                     html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html do
        redirect_to products_url, notice: 'Product was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
        format.xml
        format.json { render json: @product.to_json(include: :orders) }
        format.html
      end
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :image_url, :price)
  end
end
