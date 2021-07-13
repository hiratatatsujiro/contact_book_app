class CommentsController < ApplicationController

  def create
    @diary = Diary.find(params[:diary_id]) #①
    @comment = @diary.comments.build(comment_params) #②
    @comment.user_id = current_user.id #③
    if @comment.save
      render :index #④
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:comment, :diary_id, :user_id)
    end
end
