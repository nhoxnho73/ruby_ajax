class SessionsController < Devise::SessionsController

  def destroy
    super
    session.delete(:user_id)
    reset_session
  end

end

