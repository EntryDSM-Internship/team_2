class CommentsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required

  def create
    return render status: 400 if params[:tweetId].nil? || params[:comment].nil?

    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    begin
      Comment.create!(user_id: payload['user_id'],
                      tweet_id: params[:tweetId],
                      comment: params[:comment])
    rescue ActiveRecord::RecordInvalid
      return render status: 404
    end
    render status: 201
  end

  def destroy
    Comment.find_by_id(params[:commentId]).destroy!
    render status: 200
  end

  def show
    comment = Comment.find_by_id(params[:commentId])

    return render status: 404 unless comment

    render json: { user_id: comment.user.id,
                   user_name: comment.user.name,
                   profile_img: comment.user.user_imgs.last,
                   comment: comment.comment,
                   writed_at: comment.created_at },
           status: 200
  end
end
