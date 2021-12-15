class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def create 
    user = User.find(params[:user_id])
    newItem = user.items.create(items_params)
    render json: newItem, status: :created
  end

  def show
    render json: Item.find(params[:id]), status: :ok
  end

  private 

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end

  def items_params
    params.permit(:name, :description, :price)
  end
end
