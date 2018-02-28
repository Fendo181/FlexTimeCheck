class User < ApplicationRecord
  #DBを使わない為
  include ActiveModel::Model

  attr_accessor :id, :password, :message

  validates :id, :presence => {:message => 'ユーザidを入力してください'}
  validates :password, :presence => {:message => 'パスワードを入力してください'}
end
