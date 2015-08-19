require 'rails_helper'

RSpec.describe Identification, type: :model do

  describe "录入身份证和姓名信息成功", :type => :feature do
    it "录入身份证和姓名信息成功" do
    visit '/identification/new'
      within("#session") do
        fill_in 'name', :with => 'BOB'
        fill_in 'identical_id', :with => '222222222222222222'
      end
      click_button 'Submit'
      # 跳转的页面（create）具有的信息
      expect(page).to have_content '录入信息'
    end
  end

  describe "录入身份证和姓名信息失败", :type => :feature do
    it "录入身份证和姓名信息失败-姓名不符合格式" do
    visit '/identification/new'
      within("#session") do
        # 姓名输入错误（过长）
        fill_in 'name', :with => 'xxxxx'
        fill_in 'identical_id', :with => '222222222222222222'
      end
      click_button 'Submit'
      # 跳转的页面(重定向)具有的信息
      expect(page).to have_content 'Name is too long'
    end
  end

   describe "录入身份证和姓名信息失败", :type => :feature do
    it "录入身份证和姓名信息失败-正则表达式错误" do
    visit '/identification/new'
      within("#session") do
        # 身份证格式错误
        fill_in 'name', :with => 'john'
        fill_in 'identical_id', :with => '1111111111x'
      end
      click_button 'Submit'
      # 跳转的页面具有的信息
      expect(page).to have_content 'Identical is invalid name identical_id'
    end
  end


  describe "录入身份证和姓名信息失败", :type => :feature do
      # it "数据库里建立用户" do
      # end


      it "录入身份证和姓名信息失败-唯一性验证" do

        @id_code='111111111111111111'
        @user=Identification.create!(:name=>"john",:identical_id=>@id_code,:phonenumber=>"11111111111",:address=>"aaaaaaaaaa")
        # @user=Identification.new(:name=>"john",:identical_id=>@id_code,:phonenumber=>"11111111111",:address=>"aaaaaaaaaa")
        # @user.valid?
        #t 能保存
        # p '~~~~~~~~~~~~~'
        # p @user.errors

      visit '/identification/new'
       # p '#########################'
        within("#session") do
          # 身份证和数据库里的用户冲突
          fill_in 'name', :with => 'john'
          fill_in 'identical_id', :with => @id_code
        end
        click_button 'Submit'
        # p '@@@@@@@@@@@@@@@@@@@@@@@@@@@'
        # 跳转的页面具有的信息
        expect(page).to have_content 'Identical is already taken name identical_id'
      end
    end


describe "录入剩余的信息", :type => :feature do
    it "录入剩余信息成功" do
      visit '/identification/new'

      within("#session") do
        # 身份证格式错误
        fill_in 'name', :with => 'john'
        fill_in 'identical_id', :with => '123456789012345678'
      end
      click_button 'Submit'
      # 跳转的页面填充信息
      # visit '/supply'
      within("#session") do
        fill_in 'address', :with => 'abcdeabcde'
        fill_in 'phonenumber', :with => '11111111111'
      end
      click_button 'Submit'
      expect(page).to have_content '补充成功'
    end
  end

  describe "录入剩余的信息失败", :type => :feature do
    it "录入剩余信息失败-地址不对" do
      visit '/identification/new'

      within("#session") do
        # 身份证格式错误
        fill_in 'name', :with => 'john'
        fill_in 'identical_id', :with => '123456789012345678'
      end
      click_button 'Submit'
      # 跳转的页面填充信息
      within("#session") do
        fill_in 'address', :with => 'a'
        fill_in 'phonenumber', :with => '1'
      end
       click_button 'Submit'
       expect(current_path).to eq("/supply")
       @idf = Identification.where(:identical_id=>'123456789012345678').first
       expect(@idf.address).to eq(nil)
       expect(@idf.phonenumber).to eq(nil)
    end
  end
end
