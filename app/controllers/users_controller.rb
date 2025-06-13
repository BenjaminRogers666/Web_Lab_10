class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  load_and_authorize_resource

  def index
    unless current_user.admin?
      redirect_to chats_path, alert: "Access restricted to administrators only."
      return
    end
    @users = User.accessible_by(current_ability)
                 .includes(:messages, :sent_chats, :received_chats)
                 .order(created_at: :desc)
  end

  def show
    @chats = @user.chats.includes(:messages, :sender, :receiver)
  end

  def new
    # @user ya está inicializado por load_and_authorize_resource
  end

  def create
    if @user.save
      redirect_to @user, notice: 'Usuario creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Usuario actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Usuario eliminado correctamente.'
  end

  private

  def user_params
    params.require(:user).permit(
      :email, 
      :first_name, 
      :last_name,
      :password,
      :password_confirmation,
      :admin
    ).tap do |whitelisted|
      # Solo admins pueden modificar el campo admin
      whitelisted.delete(:admin) unless current_user.try(:admin?)
    end
  end
end