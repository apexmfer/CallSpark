class SupportlinkController < ApplicationController
  
    def create
    
    greatestorder = 0
    
    if (Supportlink.all.length > 0)
    greatestorder = Supportlink.all(:order => 'sortorder').last.sortorder
    end
    
    
    
    @link = Supportlink.new(:name => params['newlink']['name'],:url => params['newlink']['url'],:sortorder => greatestorder+1)
    
    @link.save
    
    redirect_to '/admin/supportlinks', alert: 'Link created'
  end
  
  def destroy
    link = Supportlink.find(params["link_id"])
    
    
    Supportlink.where("sortorder > ?", link.sortorder).each do |link|
      link.sortorder = link.sortorder - 1
      link.save
    end
    
    
    Supportlink.find(params["link_id"]).destroy

      redirect_to '/admin/supportlinks', alert: 'Link destroyed'
  
  end
  
  def moveup
    link = Supportlink.find(params["link_id"])
    order = link.sortorder
    swaplink = Supportlink.where(sortorder: order-1).first
    
    link.sortorder = swaplink.sortorder
    link.save
    swaplink.sortorder = order;
    swaplink.save
    
    redirect_to '/admin/supportlinks'

  end
  
   def movedown
    link = Supportlink.find(params["link_id"])
    order = link.sortorder
    swaplink = Supportlink.where(sortorder: order+1).first
    
    link.sortorder = swaplink.sortorder
    link.save
    swaplink.sortorder = order;
    swaplink.save
    
    redirect_to '/admin/supportlinks'
    
  end
  
end