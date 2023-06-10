class Admin::FeatureController < ApplicationController
  before_action :authenticate_user
  before_action :set_feature, only: [:show, :update, :destroy]

  def index
    features = Feature.all
    render json: features
  end

  def show
    render json: @feature
  end

  def create
    feature = Feature.new(feature_params)
    if feature.save
      render json: feature, status: :created
    else
      render json: feature.errors, status: :unprocessable_entity
    end
  end

  def update
    if @feature.update(feature_params)
      render json: @feature
    else
      render json: @feature.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @feature.destroy
    head :no_content
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def feature_params
    params.require(:feature).permit(:name, :vaue)
  end
end
