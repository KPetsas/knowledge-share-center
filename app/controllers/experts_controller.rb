class ExpertsController < ApplicationController

  def new
    @expert = Expert.new
  end

  def create
    @expert = Expert.new(expert_params)
    if @expert.save
      flash[:success] = "Welcome #{@expert.expertname} to Knowledge Share Center!"
      redirect_to expert_path(@expert)
    else
      render 'new'
    end
  end

  def show
    @expert = Expert.find(params[:id])
  end


  private

    def expert_params
      params.require(:expert).permit(:expertname, :email, :password, :password_confirmation)
    end

end
