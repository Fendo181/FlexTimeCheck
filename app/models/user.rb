class User
  #DBを使わない為
  include ActiveModel::Model

  attr_accessor :id, :password

  validates :id, presence: true
  validates :password, presence: true
end
