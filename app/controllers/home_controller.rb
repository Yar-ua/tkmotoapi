class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :about]
  def index
    send_response("its ok, my API works")
  end

  def about
    send_response("Information about API.")
  end

  def secure
    send_response("Secure area, only for register users.")
  end
end
