class User
  #DBを使わない為
  include ActiveModel::Model

  attr_accessor :login, :password

  validates :login, presence: true
  validates :password, presence: true
end
