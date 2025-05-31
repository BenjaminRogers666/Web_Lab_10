class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      # Lógica adicional después del login si es necesaria
    end
  end
end