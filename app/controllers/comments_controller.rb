# frozen_string_literal: true

class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret', only: :destroy

  def create
    @rate = Rate.find(params[:rate_id])
    @comment = @rate.comments.create(comment_params)
    redirect_to rate_path(@rate)
  end

  def destroy
    @rate = Rate.find(params[:rate_id])
    @comment = @rate.comments.find(params[:id])
    @comment.destroy
    redirect_to rate_path(@rate)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
