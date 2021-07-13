class CommentsController < ApplicationController

  def create
<<<<<<< Updated upstream
    @diary = Diary.find(params[:diary_id])
    @comment = Comment.new(comment_params)
    if @comment.valid? 
       @comment.save
       redirect_to diary_path(@comment.diary)
    else
      @diary = Diary.find(params[:diary_id])
      @comment = Comment.new(comment_params)
      render "diaries/show"
=======
    @diary = Diary.find(params[:diary_id]) #①
    @comment = @diary.comments.build(comment_params) #②
    @comment.user_id = current_user.id #③
    if @comment.save
      render :index #④
>>>>>>> Stashed changes
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:comment, :diary_id, :user_id)
    end
end
