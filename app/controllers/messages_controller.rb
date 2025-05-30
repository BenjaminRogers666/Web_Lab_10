class MessagesController < ApplicationController
  def index
    @messages = Message.all.includes(:user, :chat)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @chats = Chat.all
    @users = User.all
  end

  def create
    @message = Message.new(message_params)
    
    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      @chats = Chat.all
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @message = Message.find(params[:id])
    @chats = Chat.all
    @users = User.all
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to @message, notice: 'Mensaje actualizado correctamente.'
    else
      @chats = Chat.all
      @users = User.all
      render :edit, status: :unprocessable_entity
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end