class Admin::AdminController < ApplicationController
  before_action :authenticate_user
  before_action :set_admin, only: [:update]

  def index
    admins = Admin.all
    render json: admins
  end

  def update
    if @admin.update(admin_params)
      render json: @admin
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:starting_hours, :ending_hours, :name, :email, :password)
  end
end
