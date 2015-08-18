class CategoryController < ApplicationController

  def create

    newname = (params['newcategory']['name']).titleize

    @category = Category.new(:name => newname)

    @category.save

    redirect_to '/category', alert: 'Category created'
  end

  def destroy

    Category.find(params[:id]).destroy


      redirect_to '/category', alert: 'Category destroyed'

  end

  def hints

    categoryname = params['id'];

    category = Category.where( :name => categoryname).first

    render json: CategoryHint.where( :category_id => category.id )


  end




end
