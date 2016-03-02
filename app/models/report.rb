# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  spot_id    :integer
#  image      :string           not null
#

class Report < ActiveRecord::Base

  include RegexDefinition

  ### relation
  belongs_to :user
  belongs_to :spot

  mount_uploader :image, ImageUploader
  paginates_per 30

  ### before ###


  ### verify ###

  ## required
  validates_presence_of :title,
                        :content,
                        :image,
                        :user,
                        :spot

  ## digits
  # string
  validates_length_of :title, maximum: 255
  validates_length_of :content, maximum: 10000

  # integer

  ## uniqueness


  ## format


  ## other


  ### add properties ###

  def self.update_except_for_image_path(report_params)
    Report.where(@report).update_all(title: report_params[:title], content: report_params[:content], spot_id: report_params[:spot])
  end

end
