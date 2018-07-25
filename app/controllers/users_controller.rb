class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def new
    @user = User.new
    render layout: false
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      flash[:success] = "Bienvenido a tu panel de administración #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new', layout: false
    end
  end
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
end