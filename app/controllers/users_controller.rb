class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(users_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Demo!"
      redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  private

  def users_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
