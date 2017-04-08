class Helpers
  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    User.find(session[:user_id])
  end

  def self.is_admin?(session)
    !!session[:admin_id]
  end

  def self.current_admin(session)
    Admin.find(session[:admin_id])
  end

  def self.is_email?(email)
    value = email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    !!value
  end
end
