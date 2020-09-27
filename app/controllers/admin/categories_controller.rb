# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order(created_at: :desc)
  end

  def new; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = 'Create category successfully'
      redirect_to admin_categories_path
    else
      flash[:alert] = 'Create category failed'
      render :new
    end
  end

  def show
    @words = @category.words
  end

  def destroy
    @category.destroy
    flash[:success] = "Delete category successfully"
    redirect_to admin_categories_url
  end

  def edit; end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = 'Updated category successfully'
      redirect_to admin_categories_url
    else
      flash.now[:alert] = 'Updated category failed'
      render :edit
    end
  end

private
  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit :name
  end
end
