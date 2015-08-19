class CompaniesController < ActionController::Base
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @members = @company.members
    @teams = @company.teams
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to "/companies/#{@company.id}", notice: '创建成功'
    else
      redirect_to "/companies/new", notice: '创建失败'
    end 
  end

  def edit
    @company = Company.find(params[:id]) 
  end

  def update
    @company = Company.find(params[:id]) 
    if @company.update_attributes(company_params)
      redirect_to "/companies/#{@company.id}",notice:"修改公司成功"
    else
      redirect_to "/companies/#{@company.id}/edit",notice:"修改公司失败"
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    redirect_to "/companies",notice: '删除公司成功'
  end

private

  def company_params
    params.require(:company).permit(:name, :address)
  end

end