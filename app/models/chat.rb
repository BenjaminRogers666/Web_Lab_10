class Chat < ApplicationRecord
  # Asociaciones
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages, dependent: :destroy

  # Validaciones
  validates :sender_id, :receiver_id, presence: true
  validate :sender_and_receiver_different

  private
  def sender_and_receiver_different
    errors.add(:receiver_id, "no puede ser igual al remitente") if sender_id == receiver_id
  end
end