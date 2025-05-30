class ChatsController < ApplicationController
  def index
    @chats = Chat.all.includes(:sender, :receiver)
  end

  def show
    @chat = Chat.find(params[:id])
  end

  def new
    @chat = Chat.new
    @users = User.all # ← Añade esta línea
  end

  def create
    @chat = Chat.new(chat_params)
  
    if @chat.save
      redirect_to @chat, notice: 'Chat creado exitosamente.'
    else
      @users = User.all # ← Añade esta línea
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  @chat = Chat.find(params[:id])
  @users = User.all
end

def update
  @chat = Chat.find(params[:id])
  if @chat.update(chat_params)
    redirect_to @chat, notice: 'Chat actualizado correctamente.'
  else
    @users = User.all
    render :edit, status: :unprocessable_entity
  end
end

  private
  
  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end