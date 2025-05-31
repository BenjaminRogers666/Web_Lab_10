class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable # Añade trackable para last_sign_in_at

  # Associations
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy
  has_many :messages, foreign_key: 'user_id', dependent: :destroy

  # Validations
  validates :email, 
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Scopes
  scope :active, -> { where('last_sign_in_at > ?', 1.month.ago) }

  # Methods
  def chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id).includes(:messages)
  end

  def chat_with(user)
    Chat.where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", 
              id, user.id, user.id, id).first
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def admin?
    admin == true
  end

  private

  # Método para compatibilidad con Devise
  def self.find_for_database_authentication(warden_conditions)
    email = warden_conditions[:email]&.downcase
    find_by(email: email)
  end
end