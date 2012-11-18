class Player < ActiveRecord::Base
  attr_accessible :name, :nickname, :password

  def self.login(name, password)
    user = find_by_name(name)
    user && user.password == password
  end
end
