class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if params[:new] == "time"
      # @topics = Topic.order("created_at DESC")
      @topics =Topic.includes(:comments).select('id','name','created_at','last_time').order("created_at DESC")
    elsif params[:new]
      sort_by = (params[:new] == "name") ? "name" : "id"
      @topics = Topic.order(sort_by)
    elsif params[:last] == "time"
      @topics = Topic.order("last_time DESC")
    elsif params[:max] == "count"
      @topics = Topic.order("comments_count DESC")
    else
      @topics = Topic.all
    end


  end

  def new
    @topic = Topic.new
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
    @comments = @topic.comments
    @comment = @topic.comments.new()
  end

  def comment
    @topic = Topic.find(params[:id])
    @comment = @topic.comments.new(comment_params)

    if @comment.save
      @topic.last_time = @comment.created_at
      @topic.save
      redirect_to topic_path(@topic)
    end

  end

  def edit
    @topic = Topic.find(params[:id])
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
    if @topic.destroy
      redirect_to topics_path
    else
      render :index
    end

  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def topic_params
    params.require(:topic).permit(:name, :date, :description, category_ids: [])
  end
end
