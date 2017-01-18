class OrdersController < ApplicationController
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

    respond_to do |format|
      if @order.save
        format.html do
          redirect_to @order, notice: 'Order was successfully created.'
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

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
