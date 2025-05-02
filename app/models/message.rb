class Message < ApplicationRecord
  # Asociaciones
  belongs_to :chat
  belongs_to :user
  
  # Validaciones
  validates :body, :chat_id, :user_id, presence: true
end