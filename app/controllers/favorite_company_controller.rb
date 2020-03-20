class FavoriteCompanyController < ApplicationController
    before_action :require_login

  def create
     @company = Company.find_by_id(params[:id])

     if Favorite.create(favorited: @company, user: current_user)
         render text: 'Company has been favorited'
     else
         render text: 'Something went wrong...'
     end

   end

   def destroy


     @company = Company.find_by_id(params[:id])
     Favorite.where(favorited_id: @company.id, user_id: current_user.id).first.destroy
     render text: 'Company is no longer in favorites'


   end

   def index

      @user = current_user
      @companies = @user.favorite_companies
      @calls = @user.favorite_calls
      @customers = @user.favorite_customers


      if @companies.size <= 0
          render 'no_favorites'
          return
      end


   end

end
