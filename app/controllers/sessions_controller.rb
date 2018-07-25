class SessionsController < ApplicationController
  
  def new
    render layout: false
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Has iniciado sesion correctamente"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Tu usuario o contraseña son incorrectos"
      render 'new', layout: false
    end
  end
  def destroy
    session[:user_id] = nil
    flash[:success] = "Has finalizado tu sesión"
    redirect_to root_path
  end
end