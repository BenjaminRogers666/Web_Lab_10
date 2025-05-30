class Message < ApplicationRecord
  # Asociaciones
  belongs_to :chat
  belongs_to :user

  # Validaciones MEJORADAS
  validates :body, presence: { message: "no puede estar vacío" }
  validates :chat_id, :user_id, presence: true
end