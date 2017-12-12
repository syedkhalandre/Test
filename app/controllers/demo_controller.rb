class DemoController < ApplicationController
  def index
  	
  end
  
  def hello
   	@array = [1,2,3,4]
   	@id = params['id']
   	@page = params[:page]
  end
  
  def other_hello
  	redirect_to(:action => 'index')
  end

  def web
  	redirect_to("http://google.com")
  end

end
