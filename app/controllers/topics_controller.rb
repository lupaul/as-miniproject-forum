class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    category = Category.find_by(title: params[:category]) if params[:category]

    if params[:new] == "time"
      @topics = Topic.order("created_at DESC").paginate(page: params[:page], per_page: 5)
      # @topics =Topic.includes(:comments).select('id','name','created_at','last_time').order("created_at DESC")
    elsif params[:new]
      sort_by = (params[:new] == "name") ? "name" : "id"

      @topics = Topic.order(sort_by).paginate(page: params[:page], per_page: 5)
    elsif params[:last] == "time"
      @topics = Topic.order("last_time DESC").paginate(page: params[:page], per_page: 5)
    elsif params[:max] == "count"
      @topics = Topic.order("comments_count DESC").paginate(page: params[:page], per_page: 5)
    elsif category
      @topics = category.members.order("created_at DESC").paginate(page: params[:page], per_page: 5)
    elsif params[:view]
      @topics = Topic.order("viewcount DESC").paginate(page: params[:page],per_page: 5)
    else
      @topics = Topic.paginate(page: params[:page], per_page: 5)
    end


  end

  def new
    @topic = Topic.new
    @photo = @topic.build_photo
  end

  def create
    # @topic = Topic.new(topic_params)
    # @topic.user = current_user
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      flash[:notice] = "Success create!!"
      redirect_to topics_path
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @viewcount = @topic.viewcount
    @viewcount += 1
    @topic.update(viewcount: @viewcount)
    @comments = @topic.comments
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
      if @comment.photo.present?
        @photo = @comment.photo
      else
        @photo = @comment.build_photo
      end
    else
      @comment = @topic.comments.new
      @photo = @comment.build_photo
    end


  end

  def comment
    if params[:comment_id]
      @topic = Topic.find(params[:id])
      @comment = Comment.find(params[:comment_id])
      @comment.update(comment_params)
      redirect_to topic_path(@topic)
    else
      @topic = Topic.find(params[:id])
      @comment = @topic.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        @topic.last_time = @comment.created_at
        @topic.save
        redirect_to topic_path(@topic)
      end
    end

  end

  def del_comment
    @topic = Topic.find(params[:id])
    @comment = Comment.find(params[:comment_id])
    if current_user == @comment.user
      @comment.destroy
      redirect_to topic_path(@topic)
    else
      flash[:warning] = "U don't have permission"
      render :show
    end

  end

  def edit
    @topic = Topic.find(params[:id])

    if @topic.photo.present?
      @photo = @topic.photo
    else
      @photo = @topic.build_photo
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:notice] = "Success to Edit!"
      redirect_to topics_path
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    respond_to do |format|
      #:remote => true
      format.html
      format.js #destroy.js.erb
      # format.js { render text: "alert('you!')" }
    end
    # if @topic.destroy
    #   redirect_to topics_path
    # else
    #   render :index
    # end
  end

  def about

  end

  def like
    @topic = Topic.find(params[:id])
    # byebug
    unless @topic.is_like_by(current_user)
      Like.create(topic: @topic, user: current_user)

      # redirect_to topics_path(page: params[:page])
      # redirect_to :back
    end

    respond_to do |format|
      format.html { redirect_to :back}
      format.js
    end
  end

  def unlike
    @topic = Topic.find(params[:id])
    like = @topic.find_like(current_user)
    like.destroy
    # redirect_to :back

    respond_to do |format|
      format.html {redirect_to :back}
      format.js { render "like"} #like.js.erb
      # format.json { render json: @resource }
    end

  end

  def store
    @topic = Topic.find(params[:id])
    if !current_user.is_store_of?(@topic)
      current_user.store!(@topic)
      flash[:notice] = "收藏成功！！"
    else
      flash[:alert] = "U already store!!"
    end
    redirect_to topic_path(@topic)
  end

  def unstore
    @topic = Topic.find(params[:id])
    if current_user.is_store_of?(@topic)
      current_user.unstore!(@topic)
      flash[:warning] = "已取消收藏！！"
    else
      flash[:alert] = "無法取消！！"
    end
    if params[:topic]
      redirect_to :back
    else
      redirect_to topic_path(@topic)
    end
  end



  private

  def comment_params
    params.require(:comment).permit(:content, photo_attributes: [:image, :id])
  end

  def topic_params
    params.require(:topic).permit(:name, :date, :description, category_ids: [], photo_attributes: [:id, :image])
  end
end
