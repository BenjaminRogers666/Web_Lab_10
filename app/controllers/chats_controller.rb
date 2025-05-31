class ChatsController < ApplicationController
  before_action :set_users, only: [:new, :edit, :create, :update]
  load_and_authorize_resource

  def index
    @chats = Chat.accessible_by(current_ability)
                 .includes(:sender, :receiver, :messages)
                 .order(created_at: :desc)
  end

  def show
    @messages = @chat.messages.includes(:user).order(created_at: :asc)
  end

  def new
    # @chat ya está inicializado por load_and_authorize_resource
  end

  def create
    @chat.sender = current_user # Asigna automáticamente el remitente
    
    if @chat.save
      redirect_to @chat, notice: 'Chat creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @chat ya está cargado por load_and_authorize_resource
  end

  def update
    if @chat.update(chat_params)
      redirect_to @chat, notice: 'Chat actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chat.destroy
    redirect_to chats_url, notice: 'Chat eliminado correctamente.'
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id) # sender_id no debería ser modificable
  end

  def set_users
    @users = User.where.not(id: current_user.id).order(:email) # Excluye al usuario actual
  end
end