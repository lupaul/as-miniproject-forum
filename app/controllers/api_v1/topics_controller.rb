class ApiV1::TopicsController <  ApiController

  # GET http://localhost:3000/api/v1/topics.json
  def index
    @topics = Topic.all
    # render json: @topics.to_json
  end

  #GET http://localhost:3000/api/v1/topics/21.json
  def show
    @topic = Topic.find_by_id(params[:id])
    if @topic
      # render json: @topic.to_json
    else
      render json: {message: "failed!!"}, status: 400
    end
  end

  #POST http://localhost:3000/api/v1/topics/21.json
  def create
    @topic = Topic.new(name: params[:name])
    if @topic.save
      render json: {message: "OK!!"}
    else
      render json: { message: "failed!!"}, status: 400
    end
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    if @topic.update(name: params[:name])
      render json: {message: "Update Success!!"}
    else
      render json: { message: "failed!!!"}, status: 400
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:id])
    if @topic.destroy
      render json: {message: "Success delete!!"}
    else
      render json: {message: "failed!!!"}, status: 400
    end
  end
end
