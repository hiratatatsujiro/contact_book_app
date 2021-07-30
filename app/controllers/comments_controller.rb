class CommentsController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.comments.build(comment_params) 
    @comment.user_id = current_user.id 
    if @comment.save
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :diary_id, :user_id)
  end
end
