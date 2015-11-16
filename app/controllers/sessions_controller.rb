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
      flash.now[:notpermission] = "Você ainda não tem permissão"
      render "new"
    else
      flash.now[:error] = "Senha ou email inválidos"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def create_mobile
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password]) && user.permission == true
      # render :json => {"user_id" =>user.id,"admin" => user.admin,"name" => user.name}
      render :json => [user.id, user.admin, user.name]
    elsif user && user.permission == false
      render 500
    else
      render 500
    end
  end


end

