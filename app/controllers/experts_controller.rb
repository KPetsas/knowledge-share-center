class ExpertsController < ApplicationController
  before_action :get_expert_id, only: [:show, :edit, :update, :destroy]
  before_action :require_profile_owner, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @experts = Expert.paginate(page: params[:page], per_page: 5)
  end

  def show
    @expert_guides = @expert.guides.paginate(page: params[:page], per_page: 5)
  end

  def new
    @expert = Expert.new
  end

  def edit
  end

  def create
    @expert = Expert.new(expert_params)
    if @expert.save
      # automatically log in when sign up
      session[:expert_id] = @expert.id
      flash[:success] = "Welcome #{@expert.expertname} to Knowledge Share Center!"
      redirect_to expert_path(@expert)
    else
      render 'new'
    end
  end

  def update
    if @expert.update(expert_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to @expert
    else
      render 'edit'
    end
  end

  def destroy
    if !@expert.admin?
      @expert.destroy
      flash[:danger] = "Expert and all associated guides have been deleted"
      redirect_to experts_path
    end
  end


  private

    def expert_params
      params.require(:expert).permit(:expertname, :email, :password, :password_confirmation)
    end

    def get_expert_id
      @expert = Expert.find(params[:id])
    end

    def require_profile_owner
      if current_user != @expert and !current_user.admin?
        flash[:danger] = "You can edit or delete only your own account"
        redirect_to experts_path
      end
    end

    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end

end
