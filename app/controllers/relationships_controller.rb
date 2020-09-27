# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :require_login
  before_action :find_user

  def create
    if !current_user?(@user)
      if current_user.follow(@user)
        flash[:success] = 'Follow success'
        respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
      else
        flash.now[:alert] = 'Follow failed'
        respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
      end
    end
  end

  def destroy
    current_user.unfollow(@user) if !current_user?(@user)
    flash[:success] = 'Unfollowed'
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private
    def find_user
      @user = User.find(params[:user_id])
    end
end
