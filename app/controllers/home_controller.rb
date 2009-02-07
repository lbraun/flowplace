class HomeController < ApplicationController
  require_authentication :except => :logged_out
  require_authorization :admin,:only => :version
  def home
    @activities = Activity.find(:all,:limit=>10,:order => 'created_at DESC')
  end

  def logged_out
  end
  
  def version
    response.content_type = 'text/plain'
    render :text=>'version 0.0.1'
#    render :text=>`git log -1`
  end

end
