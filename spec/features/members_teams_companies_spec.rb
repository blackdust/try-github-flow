require 'rails_helper'

describe "公司增删改查", :type => :feature do
  it "注册公司" do
    visit '/companies/new'
    name    = "xiaomi"
    address = "中国北京市朝阳区小米大楼"
    fill_in 'company[name]', :with => name
    fill_in 'company[address]', :with => address 
    click_button 'Create Company'
    expect(page).to have_content '该公司职员信息'
    expect(Company.where(:address => address).first.nil?).to eq(false)
  end

  it "修改公司" do
    name2    = 'xiao'
    @company = create(:xiaomi)

    visit "/companies/#{@company.id}/edit"
    expect(page).to have_content '修改company'
    fill_in 'company[name]', :with => name2 
    click_button 'Update Company'
    expect(page).to have_content '修改公司成功'
    expect(Company.find(@company.id).name).to eq(name2)
  end

  it "删除公司" do
    create(:xiaomi)
    before_delete = Company.count
    visit '/companies'
    click_button '删除'
    expect(page).to have_content '删除公司成功'
    after_delete = Company.count
    expect(before_delete-1).to eq(after_delete)
  end
end

describe "小组增删改查", :type => :feature do
  it "注册小组" do
    @company = create(:xiaomi)
    
    visit "/companies/#{@company.id}/teams/new"
    name = "mi1"
    fill_in 'team[name]', :with => name 
    click_button 'Create Team'
    expect(page).to have_content '创建队伍成功'
    expect(Team.where(:name => name).first.nil?).to eq(false)
  end

  it "修改小组" do
    name     = "mi1"
    name2    = "mi2"
    @company = create(:xiaomi)
    @team    = @company.teams.create!(:name => name)

    visit "/companies/#{@company.id}/teams/#{@team.id}/edit"
    fill_in 'team[name]', :with => name2 
    click_button 'Update Team'
    expect(page).to have_content '修改成功'
    expect(Team.find(@team.id).name).to eq(name2)
  end

  it "删除小组" do
    name     = "mi1"
    @company = create(:xiaomi)
    @team    = @company.teams.create!(:name => name)

    before_delete = Team.count
    visit "/companies/#{@company.id}"
    click_button '删除小组'
    expect(page).to have_content '删除成功'
    after_delete = Team.count
    expect(before_delete-1).to eq(after_delete)
  end
end

describe "职员的增删改查" do
  it "添加职员失败-不在一家公司" do
    team1 = 'mi'
    team2 = 'mei'
    @company1 = create(:xiaomi)
    @team1    = @company1.teams.create!(:name => team1)
    @company2 = create(:meizu)
    @team2    = @company2.teams.create!(:name => team2)

    name      = "jack"
    phone     = "11111111111"
    card      = "123456789012345678"

    visit "/companies/#{@company1.id}/members/new"
    fill_in 'member[name]', :with => name
    fill_in 'member[phone_num]', :with => phone
    fill_in 'member[card_id]', :with => card
    page.check('mi')
    page.check('mei')
    click_button 'Create Member'
    expect(page).to have_content '创建成员失败'
    expect(Member.where(:card_id => card).first.nil?).to eq(true)
  end

   it "添加职员成功-在一家公司" do
    team1 = 'mi'
    team2 = 'mei'
    @company1 = create(:xiaomi)
    @team1    = @company1.teams.create!(:name => team1)
    @company2 = create(:meizu)
    @team2    = @company2.teams.create!(:name => team2)

    name      = "jack"
    phone     = "11111111111"
    card      = "123456789012345678"

    visit "/companies/#{@company1.id}/members/new"
    fill_in 'member[name]', :with => name
    fill_in 'member[phone_num]', :with => phone
    fill_in 'member[card_id]', :with => card
    page.check('mi')
    click_button 'Create Member'
    expect(page).to have_content '创建成员成功'
    expect(Member.where(:card_id => card).first.nil?).to eq(false)
  end

  it "删除成员" do
    team_name = 'mi'
    @company1 = create(:xiaomi)
    @team1    = @company1.teams.create!(:name => team_name)
    name      = "jack"
    phone     = "11111111111"
    card      = "123456789012345678"

    visit "/companies/#{@company1.id}/members/new"
    fill_in 'member[name]', :with => name
    fill_in 'member[phone_num]', :with => phone
    fill_in 'member[card_id]', :with => card
    page.check('mi')
    click_button 'Create Member'
    expect(page).to have_content '创建成员成功'
    before_delete = Member.count
    visit "/companies/#{@company1.id}"
    click_button '删除成员'
    expect(page).to have_content '删除成功'
    after_delete = Member.count
    expect(before_delete-1).to eq(after_delete)
  end

  it "修改职员-移动到另外的组" do
    team1 = 'mi'
    team2 = 'mei'
    @company1 = create(:xiaomi)
    @team1    = @company1.teams.create!(:name => team1)
    @company2 = create(:meizu)
    @team2    = @company2.teams.create!(:name => team2)

    name      = "jack"
    phone     = "11111111111"
    card      = "123456789012345678"

    visit "/companies/#{@company1.id}/members/new"
    fill_in 'member[name]', :with => name
    fill_in 'member[phone_num]', :with => phone
    fill_in 'member[card_id]', :with => card
    page.check('mi')
    click_button 'Create Member'
    expect(page).to have_content '创建成员成功'

    visit "/companies/#{@company1.id}"
    click_button '修改成员'
    #进入edit页面在复选框内重新选择team
    fill_in 'member[name]', :with => name
    fill_in 'member[phone_num]', :with => phone
    fill_in 'member[card_id]', :with => card
    page.uncheck('mi')
    page.check('mei')
    click_button 'Update Member'
    expect(page).to have_content '修改成功'
    @new_team = Team.find(Member.where(:card_id => card).first.team_ids).first.name
    expect(@new_team).to eq('mei')
  end
end



