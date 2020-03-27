class UsernameValidator < ActiveModel::Validator
  def validate(record)
    unless User.find_by(slug: record.username.downcase).nil?
      record.errors[:username] << "An account with that username already exists."
    end
    unless record.username.match?(/[a-zA-Z0-9\-\_]/)
      record.errors[:username] << "Username must only consist of letters, numbers, hyphen, and underscores."
    end
    unless record.password.match?(/[a-zA-Z0-9\-\_]/)
      record.errors[:password] << "Password must only consist of letters, numbers, hyphen, and underscores."
    end
  end
end
