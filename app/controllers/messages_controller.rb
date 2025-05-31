class MessagesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_chats_for_current_user, only: [:new, :edit, :create, :update]
  
  def index
    # Mostrar solo mensajes de chats donde el usuario participa
    @messages = Message.joins(:chat)
                      .where(chats: { id: current_user.chats })
                      .includes(:user, :chat)
  end

  def show
    # load_and_authorize_resource ya maneja esto
  end

  def new
    # load_and_authorize_resource ya inicializa @message
  end

  def create
    @message.user = current_user # Asignar automáticamente el usuario actual
    
    if @message.save
      redirect_to chat_path(@message.chat), notice: 'Mensaje enviado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # load_and_authorize_resource ya maneja esto
  end

  def update
    if @message.update(message_params)
      redirect_to chat_path(@message.chat), notice: 'Mensaje actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  
  def message_params
    # Eliminamos :user_id de los parámetros permitidos
    params.require(:message).permit(:chat_id, :body)
  end
  
  def set_chats_for_current_user
    @chats = current_user.chats
  end
end