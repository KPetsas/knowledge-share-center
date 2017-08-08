class SessionsController < ApplicationController

  def new
  end

  def create
    expert = Expert.find_by(email: params[:session][:email].downcase)
    if expert && expert.authenticate(params[:session][:password])
      session[:expert_id] = expert.id
      cookies.signed[:expert_id] = expert.id
      flash[:success] = "You have successfully logged in"
      redirect_to expert
    else
      flash.now[:danger] = "The combination of e-mail and password could not be found"
      render 'new'
    end
  end

  def destroy
    session[:expert_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to root_path
  end

end
