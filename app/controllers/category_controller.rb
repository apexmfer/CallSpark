class CategoryController < ApplicationController
  
  def create
    
    @category = Category.new(:name => params['newcategory']['name'])
    
    @category.save
    
    redirect_to '/admin/categories', alert: 'Category created'
  end
  
  def destroy
    
    Category.find(params["category_id"]).destroy


      redirect_to '/admin/categories', alert: 'Category destroyed'
  
  end
  
  def hints
    
    categoryname = params['id'];
    
    category = Category.where( :name => categoryname).first
    
    
    
    render json: CategoryHint.where( :parent_id => category.id )
    
    
  end
  
  
  
  
end
