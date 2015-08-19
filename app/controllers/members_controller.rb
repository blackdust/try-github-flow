class MembersController < ActionController::Base

  def new
    @company = Company.find(params[:company_id])
    @member  = Member.new
    @teams   = Team.all
  end

  def create
    name      = params[:member][:name]
    phone_num = params[:member][:phone_num]
    card_id   = params[:member][:card_id]
    team_ids  = params[:member][:team_ids]
    @company  = Company.find(params[:company_id])
    @member   = @company.members.new(:name=>name,:phone_num=>phone_num,:card_id=>card_id,:team_ids=>team_ids)
    if @member.save
      redirect_to "/companies/#{@company.id}", notice: '创建成员成功'
    else
      redirect_to "/companies/#{@company.id}/members/new", notice: '创建成员失败'
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @member  = Member.find(params[:id])
  end

  def update
    @company  = Company.find(params[:company_id])
    @member   = Member.find(params[:id])
    name      = params[:member][:name]
    phone_num = params[:member][:phone_num]
    card_id   = params[:member][:card_id]
    team_ids  = params[:member][:team_ids]
    if @member.update_attributes(:name=>name,:phone_num=>phone_num,:card_id=>card_id,:team_ids=>team_ids)
      redirect_to "/companies/#{params[:company_id]}", notice: '修改成功'
    else
      @member.valid?
      redirect_to "/companies/#{params[:company_id]}/members/#{@member.id}/edit", notice: @member.errors
    end
  end

  def destroy
    member = Member.find(params[:id])
    member.destroy
    redirect_to "/companies/#{params[:company_id]}",notice: '删除成功'   
  end

private

  # def create_member_params
  #   params.require(:member).permit(:name,:phone_num,:card_id,:team_ids)   
  # end  
end