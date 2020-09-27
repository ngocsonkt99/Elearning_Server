# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'Sign Up Success'
      redirect_to root_path
    else
      flash.now[:warning] = 'Registration Failed'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Update Success'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end

private
  def user_params
    params.require(:user).permit :email, :fullname, :password, :password_confirmation, :avatar
  end
end
