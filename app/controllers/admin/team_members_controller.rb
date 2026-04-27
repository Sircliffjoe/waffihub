class Admin::TeamMembersController < Admin::BaseController
  before_action :set_team_member, only: [ :show, :edit, :update, :destroy ]

  def index
    @team_members = TeamMember.all.order(:name)
  end

  def show
  end

  def new
    @team_member = TeamMember.new
  end

  def edit
  end

  def create
    @team_member = TeamMember.new(team_member_params)
    if @team_member.save
      redirect_to admin_team_members_path, notice: "Team member was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @team_member.update(team_member_params)
      redirect_to admin_team_members_path, notice: "Team member was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team_member.destroy
    redirect_to admin_team_members_path, notice: "Team member was successfully destroyed.", status: :see_other
  end

  private

  def set_team_member
    @team_member = TeamMember.find(params[:id])
  end

  def team_member_params
    params.require(:team_member).permit(:name, :role, :bio, :image)
  end
end
