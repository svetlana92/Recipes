class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find params[:id]
  end
end
