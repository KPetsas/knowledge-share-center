class GuidesController < ApplicationController

  def index
    @guides = Guide.all
  end

  def show
    @guide = Guide.find(params[:id])
  end

  def new
    @guide = Guide.new
  end

  def create
    @guide = Guide.new(guide_params)
    @guide.expert = Expert.first  # temporary until experts (users) are created
    if @guide.save
      flash[:success] = "Guide was created successully!"
      redirect_to guide_path(@guide)
    else
      render 'new'
    end
  end


  private

    def guide_params
      params.require(:guide).permit(:title, :instructions)
    end

end
