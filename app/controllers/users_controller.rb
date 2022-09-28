class UsersController < ApplicationController
  def index
    @users = User.all.sort_by{|user| -user.points} 
  end

  def show
    @user = User.find(params[:id])
  end
end
