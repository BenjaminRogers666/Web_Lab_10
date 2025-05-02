class User < ApplicationRecord
  # Asociaciones
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy
  has_many :messages, dependent: :destroy

  # Validaciones
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  # Método para obtener todos los chats del usuario
  def all_chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end
end