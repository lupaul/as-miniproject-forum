class WelcomeController < ApplicationController
  def index
    flash[:notice] = "hello!!!"
    flash[:warning] = "warning!!!"
    flash[:alert] = 'Oh!!!!'
  end
end
