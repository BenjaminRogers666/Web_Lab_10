class User < ApplicationRecord
  # Asociaciones CORREGIDAS
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy
  has_many :messages, foreign_key: 'user_id', dependent: :destroy

  # Método para obtener todos los chats (reemplaza .chats)
  def chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end

  # Validaciones
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
end