class GuidesController < ApplicationController
  before_action :get_guide_id, only: [:show, :edit, :update, :destroy]

  def index
    @guides = Guide.paginate(page: params[:page], per_page: 5)
  end

  def show
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
  end

  def update
    if @guide.update(guide_params)
      flash[:success] = "Guide was successfully updated!"
      redirect_to guide_path(@guide)
    else
      render 'edit'
    end
  end

  def destroy
    @guide.destroy
    flash[:success] = "Guide deleted successfully"
    redirect_to guides_path
  end


  private

    def get_guide_id
      @guide = Guide.find(params[:id])
    end

    def guide_params
      params.require(:guide).permit(:title, :instructions)
    end

end
