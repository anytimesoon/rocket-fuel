module FormValidator
  def is_email?(email)
    value = email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    !!value
  end
end