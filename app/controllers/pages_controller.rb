class PagesController < ApplicationController

  def home
    redirect_to guides_path if logged_in?
  end
  
end
