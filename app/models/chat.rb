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
    if sender_id == receiver_id
      errors.add(:receiver_id, "must be different from sender")
    end
  end
end