class Api::V1::SessionsController < ApplicationController

  def create
    ##binding.pry
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      render json: @user
    else
      render json: {
        error: "Invalid credentials"
      }
    end
  end

  def get_current_user
    if logged_in?
      ##render json: @user
      render json: current_user
    ##else
    ##  render json: {
    ##    error: "No one logged in"
    ##  }
    end
  end

  def destroy
    session.clear
    render json: {
      notice: "Logged out"
    }, status: :ok
  end

end
