class ItemCommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @item_comment = @item.item_comments.build(comment_params) 
    @item_comment.user_id = current_user.id 
    if @item_comment.save
      render :index
    end
  end

  private

  def comment_params
    params.require(:item_comment).permit(:comment, :item_id, :user_id)
  end
end
