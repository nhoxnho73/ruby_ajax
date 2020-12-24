module Login

  def sign_in(user)
    @user = user

  end

  def logout
    @user = nil
  end

  def current_user
    @user
  end


end