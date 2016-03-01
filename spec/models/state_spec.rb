# == Schema Information
#
# Table name: states
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  two_digit_code :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

Rspec.describe City, :type => :model do

  let(:member) { build(:member) }
  let(:member_create) { create(:member, birthday: '1980-02-01') }

  describe "正常系チェック" do

    example "正常なオブジェクト" do
      expect(member).to be_valid
    end

  end
  describe "事前処理チェック" do

    describe "索引用メールアドレスの変換代入処理" do

      example "メールアドレスの大文字が小文字に変換されて索引用メールアドレスに格納される" do
        mail_downcase = member["mail_address"].downcase
        expect(member["mail_address_for_index"]).to eq(mail_downcase)
      end

    end

  end

  describe "必須項目チェック" do

    # チェック対象カラム名の配列を作成
    presence_chk = %w(mail_address family_name family_name_kana given_name given_name_kana sex_division birthday point_member_code member_maximum_amount_id billing_scheme_id member_sign_up_status member_registration_datetime verification_status)
    # 必須チェック
    presence_chk.each do |column_name|
      example "#{column_name} は空であってはならない" do
        member[column_name] = ''
        expect(member).not_to be_valid
        if column_name =~ /\A.*_id\z/
          column_name_excepting_id = column_name.gsub(/_id\z/, '')
          expect(member.errors[column_name_excepting_id]).to be_present
        else
          expect(member.errors[column_name]).to be_present
        end
      end
    end

  end

  describe "桁数チェック" do

    # チェック対象カラム名をkey,最大桁数をvalueとしてハッシュを作成
    limit_chk = {"mail_address" => 255,
                 # "mail_address_for_index" => 255,
                 "member_code" => 9,
                 "point_member_code" => 9,
                 "family_name" => 50,
                 "family_name_kana" => 64,
                 "given_name" => 50,
                 "given_name_kana" => 64,
                 "sex_division" => 1,
                 "member_sign_up_status" => 1,
                 "verification_status" => 1
    }

    limit_chk.each do |column_name, column_limit|
      example "#{column_name} は#{column_limit}文字以内" do
        if (column_name == "mail_address" )
          # メールアドレス
          member[column_name] = ("a" * column_limit.to_i) + "@npay.jp"
        elsif (column_name == "family_name" || column_name == "given_name")
          # 全角
          member[column_name] = "漢" * (column_limit.to_i + 1)
        elsif (column_name == "family_name_kana" || column_name == "given_name_kana")
          # 全角かな
          member[column_name] = "あ" * (column_limit.to_i + 1)
        elsif (column_name == "sex_division" || column_name == "member_sign_up_status" || column_name == "verification_status" || column_name == "member_code" || column_name == "point_member_code")
          # 半角のみ、数値（区分値）
          member[column_name] = "1" * (column_limit.to_i + 1)
        else
          # その他
          member[column_name] = "a" * (column_limit.to_i + 1)
        end
        expect(member).not_to be_valid
        expect(member.errors[column_name]).to be_present
      end
    end

  end

  describe "一意性チェック" do

    # 一意性チェックを行いたい項目を「配列」として配列に格納（組み合わせも検証可能）
    uniqueness_chk =[["mail_address_for_index", "member_code", "point_member_code"]]
    uniqueness_chk.each do |columns|
      describe "#{columns.join(', ')}の一意性検証" do
        example "#{columns.join(', ')}は一意である" do
          # 一度保存し、保存された項目と同じ値を設定することで一意性を検証
          member.save
          member_uniq_chk = build(:member)
          columns.each do |column_name|
            member_uniq_chk[column_name] = member[column_name]
            member_uniq_chk["mail_address"] = member["mail_address"] if column_name == "mail_address_for_index"
          end
          expect(member_uniq_chk).not_to be_valid
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

    describe "関連チェック" do
      example  "１つ請求スキームに属する" do
        expect(member).to belong_to(:billing_scheme)
      end
      example  "１つ会員上限金額に属する" do
        expect(member).to belong_to(:member_maximum_amount)
      end
      example  "１つの会員利用状況を持つ" do
        expect(member).to have_one(:member_usage)
      end
    end

  end

end
