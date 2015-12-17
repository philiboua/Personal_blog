class HomeController < ApplicationController 

  layout 'admin', only: :test 
  
  def index 
  end 

  def test 
  end
  
end