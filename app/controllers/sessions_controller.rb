class SessionsController < ApplicationController
  def new
    @erro_login = false
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.permission == true
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember user
      redirect_to user
    elsif user && user.permission == false
      flash.now[:notpermission] = "You do not have a permission"
      render "new"
    else
      flash.now[:error] = "Invalid password or email"
      render "new"
    end
  end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end

