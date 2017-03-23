class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @topics = Topic.all
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

  def topic_params
    params.require(:topic).permit(:name, :date, :description)
  end

end
