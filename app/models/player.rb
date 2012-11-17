class Player < ActiveRecord::Base
  attr_accessible :name, :nickname, :password

  def self.login(name, password)
    user = Self.find_by_login(name)
    user.password == password
  end
end
