class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  include CurrentCart

  before_action :set_cart, only: [:new, :create]
  before_action :ensure_cart_not_empty, only: :new

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session.delete(:cart_id)

        OrderMailer.received(@order).deliver_later

        format.html do
          redirect_to store_index_url, notice: I18n.t('.thanks')
        end
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json do
          render json: @order.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html do
          redirect_to @order, notice: 'Order was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json do
          render json: @order.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html do
        redirect_to orders_url, notice: 'Order was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def ensure_cart_not_empty
    if @cart.line_items.empty?
      redirect_to store_index_url, notice: "Your cart is empty"
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
