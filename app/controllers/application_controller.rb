class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include UsersHelper

  def hello
    render html: "hello, world!"
  end
end
