class MessagesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @messages = Message.accessible_by(current_ability)
                       .includes(:user, :chat)
                       .order(created_at: :desc)
  end

  def show
    # @message is loaded by load_and_authorize_resource
  end

  def new
    @chats = current_user.chats
  end

  def create
    @message.user = current_user unless current_user.admin?
    
    if @message.save
      redirect_to @message.chat, notice: 'Message was successfully created.'
    else
      @chats = current_user.chats
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @chats = current_user.chats
  end

  def update
    if @message.update(message_params)
      redirect_to @message.chat, notice: 'Message updated successfully.'
    else
      @chats = current_user.chats
      render :edit, status: :unprocessable_entity
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:chat_id, :body).tap do |p|
      p[:user_id] = current_user.id unless current_user.admin?
    end
  end
end