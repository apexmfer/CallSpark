class FavoriteCompanyControllerController < ApplicationController


  def create
     @company = Company.find(params[:id])

     if Favorite.create(favorited: @company, user: current_user)
         render text: 'Company has been favorited'
     else
         render text: 'Something went wrong...'
     end

   end

   def destroy
     @company = Company.find(params[:id])
     Favorite.where(favorited_id: @company.id, user_id: current_user.id).first.destroy
     render text: 'Company is no longer in favorites'


   end

end
