class CategoryController < ApplicationController

    before_action :require_login

  def create

    newname = (params['newcategory']['name']).titleize

    @category = Category.new(:name => newname)

    @category.save

    redirect_to '/category', alert: 'Category created'
  end


  def merge

      thisCategory = Category.find(params[:id])
      consumerCategory = Category.find(params[:consumer_id])

      Call.all.each do |call|
        if(call.category_id == thisCategory.id)
            call.category_id = consumerCategory.id
            call.save
        end
      end

      destroy()


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
