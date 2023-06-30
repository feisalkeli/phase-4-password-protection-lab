class UsersController < ApplicationController
before_action :authenticate_user, only:[:show]
  def create 
    user= User.new(user_params)
    user.password = params[:password]
    if user.save
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end


def show 
  render json: user
end

  private 
  def user_params 
    params.permit(:username,:password,:password_confirmation)
  end
  def authenticate_user 
    user = User.find_by(id: params[:id])
    if user && user.authenticate(params[:password])
      render json: user
      else
        render json: {errors: "Invalid username or password"}, status: :unprocessable_entity
  end

    
end
