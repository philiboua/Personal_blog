class RegistrationsController < Devise::RegistrationsController

  before_action :single_user_registered?
  
  protected

  def single_user_registered?
    if ((User.count == 1) & (user_signed_in?))
      redirect_to root_path
    elsif User.count == 1
      redirect_to new_user_session_path
    end  
  end

  def after_sign_up_path_for(resource)
    new_profile_path
  end

end