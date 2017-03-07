class Administrator < ActiveRecord::Base
  include EmailHolder#↓共通モジュール化
  # before_validation do
  #   self.email_for_index = email.downcase if email
  # end

  include PasswordHolder#↓共通モジュール化
  # def password=(raw_password)
  #   if raw_password.kind_of?(String)
  #     self.hashed_password = BCrypt::Password.create(raw_password)
  #   elsif raw_password.nil?
  #     self.hashed_password = nil
  #   end
  # end
end
