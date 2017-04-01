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
      flash[:success] = "Guide was created successfully!"
      redirect_to guide_path(@guide)
    else
      render 'new'
    end
  end

  def edit
    @guide = Guide.find(params[:id])
  end

  def update
    @guide = Guide.find(params[:id])
    if @guide.update(guide_params)
      flash[:success] = "Guide was successfully updated!"
      redirect_to guide_path(@guide)
    else
      render 'edit'
    end
  end

  def destroy
    @guide = Guide.find(params[:id])
    @guide.destroy
    flash[:success] = "Guide deleted successfully"
    redirect_to guides_path
  end


  private

    def guide_params
      params.require(:guide).permit(:title, :instructions)
    end

end
