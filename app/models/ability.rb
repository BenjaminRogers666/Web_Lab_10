class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, User
    
    if user.persisted?
      can [:show, :edit, :update, :destroy], User, id: user.id
      
      # Cambiamos el bloque por condiciones SQL
      can [:read, :update], Chat, ['sender_id = ? OR receiver_id = ?', user.id, user.id] do |chat|
        chat.sender_id == user.id || chat.receiver_id == user.id
      end
      
      can :destroy, Chat, sender_id: user.id
      can :create, Chat
      
      can :create, Message
      can [:read, :update, :destroy], Message, user_id: user.id

      if user.admin?
        can :manage, :all
      end
    end
  end
end