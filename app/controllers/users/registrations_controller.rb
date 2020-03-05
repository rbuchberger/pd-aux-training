class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    if resource.deactivate
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message :notice, :destroyed if is_flashing_format?
      yield resource if block_given?
      respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
    else
      flash[:alert] =
        'Please create another administrator before deactivating your account.'
      redirect_to edit_user_registration_path
    end
  end
end
