class CategoryHintController < ApplicationController
  
  
  def create
    
    @category = CategoryHint.new(:category_id => params['newhint']['category_id'],:parent_id => params['newhint']['parent_id'],:text => params['newhint']['text'])
    
    @category.save
    
    redirect_to '/admin/category_hints', alert: 'Hint created'
  end
  
  def destroy
    
    CategoryHint.find(params["hint_id"]).destroy

      redirect_to '/admin/category_hints', alert: 'Hint destroyed'
  
  end
  
end
