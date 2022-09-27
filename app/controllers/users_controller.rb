class UsersController < ApplicationController
  def index
    @users = User.all.sort_by{|user| -user.points} 
  end
end
