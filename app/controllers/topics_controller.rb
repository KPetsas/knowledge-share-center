class TopicsController < ApplicationController
  before_action :get_topic_id, only: [:show, :edit, :update]
  before_action :require_admin, except: [:show, :index]

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:success] = "Topic was successfully created"
      redirect_to topics_path(@topic)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      flash[:success] = "Topic was updated successfully"
      redirect_to @topic
    else
      render 'edit'
    end
  end

  def show
    @topic_guides = @topic.guides.paginate(page: params[:page], per_page: 5)
  end

  def index
    @topics = Topic.paginate(page: params[:page], per_page: 5)
  end

  private

    def get_topic_id
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:name)
    end

    def require_admin
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = "Only admin users can perform that action"
        redirect_to topics_path
      end
    end

end
