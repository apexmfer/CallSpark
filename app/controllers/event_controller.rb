class EventController < ApplicationController
  
  
  
  def create
    
    @event = Event.new(:name => params['newevent']['name'],:description => params['newevent']['description'],:date => params['newevent']['date'])
    
    @event.save
    
    redirect_to '/admin/events', alert: 'Event created'
  end
  
  def destroy
    
    Event.find(params["event_id"]).destroy


      redirect_to '/admin/events', alert: 'Event destroyed'
  
  end
  
  
  
end
