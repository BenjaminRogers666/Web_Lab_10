class PasswordsController < Devise::PasswordsController
  def create
    email = params[:user][:email].to_s.downcase
    @user = User.find_by(email: email)

    if @user
      raw_token = @user.send_reset_password_instructions
      redirect_to edit_user_password_path(reset_password_token: raw_token),
                  notice: 'Por favor ingresa tu nueva contraseña'
    else
      flash.now[:alert] = 'No encontramos una cuenta con ese email'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      sign_in(resource_name, resource)
      flash[:success] = '¡Contraseña actualizada con éxito!'
      redirect_to after_resetting_password_path_for(resource)
    else
      flash.now[:alert] = "Error: #{resource.errors.full_messages.to_sentence}"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def after_resetting_password_path_for(_resource)
    root_path # O custom_path si prefieres otra redirección
  end
end