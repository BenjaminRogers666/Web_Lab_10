class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc) # Elimina los includes innecesarios para la vista index
  end

  def show
    @user = User.find(params[:id])
    @chats = @user.all_chats # Usamos el método que definimos en el modelo
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  
    if @user.save
      redirect_to @user, notice: 'Usuario creado exitosamente.'
    else
      render :new, status: :unprocessable_entity # Esta línea ya está correcta
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Usuario actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end 
  
  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end