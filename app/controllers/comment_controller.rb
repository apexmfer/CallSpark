class CommentController < ApplicationController


  def create


      body = params[:body]
      commentable_id = params[:commentable_id]
      commentable_class_type = params[:commentable_class_type] # a string like 'project'

      commentable_class = commentable_class_type.classify.safe_constantize

      commentable_record =  commentable_class.find_by_id(commentable_id)

      @user_who_commented =  current_user
      @comment = Comment.build_from( commentable_record, @user_who_commented.id, body  )


      render json: @comment

  end

  def show
    @comment = Comment.find_by_id[:id]
  end



end
