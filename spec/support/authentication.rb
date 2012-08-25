module AcceptanceHelpers

  def log_in(user)
    visit log_in_path
    fill_in 'email', :with => user.email
    fill_in 'password', :with => user.password
    click_button 'log in'
  end

end

module ControllerHelpers

  def current_user
    User.find session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end
end
