class ApplicationController < ActionController::Base
  require 'yelp'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # yelp client
  def get_yelp_client
    return client = Yelp::Client.new({ consumer_key: "iRqAn6lcvbvdeMrlKezluQ",
                              consumer_secret: "wXs5hbhdXVdV2w9ZWTBWR4O9KXE",
                              token: "taZEZBVR3FMAOI8cTbkUX4vZ3Sh2SxjB",
                              token_secret: "xvR6PJQOsR9b0Tnr7-OP_tnKXCs"
                            })
  end

  private
  def not_authenticated
    redirect_to login_url, :alert => "First log in to view this page."
  end

end
