class CommentsController < ApplicationController
  before_action :require_user

  def create
    # debugger
    @guide = Guide.find(params[:guide_id])
    @comment = @guide.comments.build(comment_params)
    @comment.expert = current_user  # require user ensures that we have a current_user
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      # flash[:success] = "Comment was created successfully"
      # redirect_to guide_path(@guide)
    else
      flash[:danger] = "Comment was not created"
      redirect_to :back
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:description)
    end

end
