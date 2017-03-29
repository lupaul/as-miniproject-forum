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
    else
      @topics = Topic.paginate(page: params[:page], per_page: 5)
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
    @comment.user = current_user


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
      
      redirect_to topics_path(page: params[:page])
      # redirect_to :back
    end
  end

  def unlike
    @topic = Topic.find(params[:id])
    like = @topic.find_like(current_user)

    like.destroy
    redirect_to :back

  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def topic_params
    params.require(:topic).permit(:name, :date, :description, category_ids: [])
  end
end
