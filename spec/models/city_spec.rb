# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  county_id  :integer
#

require 'rails_helper'

Rspec.describe City, :type => :model do

  let(:city) { build(:city) }

  describe "正常系チェック" do

    example "正常なオブジェクト" do
      expect(city).to be_valid
    end

  end
  describe "事前処理チェック" do
  end

  describe "必須項目チェック" do

    # チェック対象カラム名の配列を作成
    presence_chk = %w(name)
    # 必須チェック
    presence_chk.each do |column_name|
      example "#{column_name} は空であってはならない" do
        city[column_name] = ''
        expect(city).not_to be_valid
        if column_name =~ /\A.*_id\z/
          column_name_excepting_id = column_name.gsub(/_id\z/, '')
          expect(city.errors[column_name_excepting_id]).to be_present
        else
          expect(city.errors[column_name]).to be_present
        end
      end
    end

  end

  describe "桁数チェック" do

    # チェック対象カラム名をkey,最大桁数をvalueとしてハッシュを作成
    limit_chk = {"name" => 255
    }

    limit_chk.each do |column_name, column_limit|
      example "#{column_name} は#{column_limit}文字以内" do
        if (column_name == "name" )
          # 全角
          city[column_name] = "漢" * (column_limit.to_i + 1)
        end
        expect(city).not_to be_valid
        expect(city.errors[column_name]).to be_present
      end
    end

  end

  describe "一意性チェック" do

    # 一意性チェックを行いたい項目を「配列」として配列に格納（組み合わせも検証可能）
    uniqueness_chk =[["name"]]
    uniqueness_chk.each do |columns|
      describe "#{columns.join(', ')}の一意性検証" do
        example "#{columns.join(', ')}は一意である" do
          # 一度保存し、保存された項目と同じ値を設定することで一意性を検証
          city.save
          city_uniq_chk = build(:city)
          columns.each do |column_name|
            city_uniq_chk[column_name] = city[column_name]
          end
          expect(city_uniq_chk).not_to be_valid
        end
      end
    end

  end

  describe "入力値チェック" do

    describe "メールアドレス" do

      # ポイント会員側のバリデーションロジックに沿う
      column_name = "mail_address"
      example "半角を含む" do
        member[column_name] = "yaizawa@netprotections.co.jp"
        expect(member).to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "全角を含まない" do
        member[column_name] = "ｙａｉｚａｗａ@netprotections.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "メールアドレス形式である" do
        member[column_name] = "yaizawa@netprotections.co.jp"
        expect(member[column_name]).to match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
        expect(member).to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "メールアドレス形式でない場合はエラーとなる" do
        member[column_name] = "yaizawa#netprotections.co.jp"
        expect(member[column_name]).not_to match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      ### ポイント会員側チェック仕様
      example "ローカル部が半角英数字、記号（._!#$%&'*+-/=?^_`{|}~）で構成されている" do
        member[column_name] = "yaizawaYAIZAWA0123456789._!#$%&'*+-/=?^_`{|}~@netprotections.co.jp"
        expect(member).to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "ドメイン部が半角英数と記号（-.）で構成されている" do
        member[column_name] = "yaizawaYAIZAWA0123456789._!#$%&'*+-/=?^_`{|}~@netprotections-123.co.jp"
        expect(member).to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "@が二つ以上含まれている(ローカル(ユーザ)部、ドメイン部に分離できない)" do
        member[column_name] = "yaizawa@netpr@otections.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "@が含まれていない(ローカル(ユーザ)部、ドメイン部に分離できない)" do
        member[column_name] = "yaizawanetprotections.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "ドメイン部の先頭文字列が-(ハイフン)" do
        member[column_name] = "yaizawa@-netprotections.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "ドメイン部の先頭文字列が.(ピリオド)" do
        member[column_name] = "yaizawa@.netprotections.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "ドメイン部の最後の文字列が.(ピリオド)" do
        member[column_name] = "yaizawa@netprotections.co.jp."
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "ドメイン部に.(ピリオド)が含まれていない" do
        member[column_name] = "yaizawa@netprotections"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "ドメイン部に..(ピリオドの連続)が含まれている" do
        member[column_name] = "yaizawa@netprotection..s.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "登録対象外:*@で始まるメールアドレス" do
        member[column_name] = "*@netprotections.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "登録対象外:xxx@netprotections.co.jp" do
        member[column_name] = "xxx@netprotections.co.jp"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end
      example "登録対象外:xxx@xxx.xxx" do
        member[column_name] = "xxx@xxx.xxx"
        expect(member).not_to be_valid
        puts "#{column_name} error:#{member.errors[column_name]}"
      end

    end

    describe "relation check" do
      example  "belong to county" do
        expect(city).to belong_to(:county)
      end
      example  "has many spots" do
        expect(city).to has_many(:spots)
      end
      example  "has many users" do
        expect(city).to has_many(:users)
      end
      example  "has many zips" do
        expect(city).to has_many(:zips)
      end
    end

  end

end
