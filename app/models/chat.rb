class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages, dependent: :destroy

  scope :for_user, ->(user) { where("sender_id = ? OR receiver_id = ?", user.id, user.id) }

  def other_participant(current_user)
    sender == current_user ? receiver : sender
  end

  # Método para verificar participación
  def involves?(user)
    sender_id == user.id || receiver_id == user.id
  end

  # Método para obtener el otro participante
  def other_participant(current_user)
    sender == current_user ? receiver : sender
  end

  private

  def sender_and_receiver_different
    errors.add(:receiver_id, "no puede ser igual al remitente") if sender_id == receiver_id
  end
end