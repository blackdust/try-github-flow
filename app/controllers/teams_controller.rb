class TeamsController < ActionController::Base
  def new
    @company = Company.find(params[:company_id])
    @team = Team.new

  end

  def index
    @teams = Team.all
  end

  def create
    @company = Company.find(params[:company_id])
    @team = @company.teams.new(create_team_params)
    if @team.save
      redirect_to "/companies/#{@company.id}", notice: '创建队伍成功'
    else
      redirect_to "/companies/#{@company.id}/teams/new", notice: '创建队伍失败'
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @team = Team.find(params[:id])
  end

  def update
    @company = Company.find(params[:company_id])
    @team = Team.find(params[:id])
    if @team.update_attributes(create_team_params)
      redirect_to "/companies/#{params[:company_id]}", notice: '修改成功'
    else
      redirect_to "/companies/#{params[:company_id]}/teams/#{@team.id}", notice: '修改失败'
    end
  end
  
  def destroy
    team = Team.find(params[:id])
    team.destroy
    redirect_to "/companies/#{params[:company_id]}",notice: '删除成功'
  end

private
  def create_team_params
     params.require(:team).permit(:name)
  end  
end