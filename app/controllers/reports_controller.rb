include ConstDefinition

class ReportsController < ApplicationController

  before_filter :require_login, :only => [:edit, :update, :destroy]
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_filter :ope_report_filter, only: [:edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all.order("updated_at DESC").page(params[:page])
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @other_reports = Report.where(yelp_business_id: @report.spot.yelp_business_id)
  end

  # GET /reports/new
  def new
    @report = Report.new
    @city = {
        :id => current_user.city.id,
        :display => "#{current_user.city.name}, #{current_user.city.county.state.two_digit_code}"
    }
  end

  # GET /reports/1/edit
  def edit
    @city = {
        :id => @report.spot.city.id,
        :display => "#{@report.spot.city.name}, #{@report.spot.city.county.state.two_digit_code}"
    }
    @spot_on_yelp = {
        :id => @report.spot.yelp_business_id,
        :display => "#{@report.spot.name} (#{@report.spot.city.name})"
    }
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @city = {
        :id => current_user.city.id,
        :display => "#{current_user.city.name}, #{current_user.city.county.state.two_digit_code}"
    }
    yelp_business_id = params[:report][:yelp_business_id]
    return render :new if yelp_business_id.blank?

    spot = Spot.where(yelp_business_id: yelp_business_id).first
    if spot.blank? then
      spot = get_spot_info(yelp_business_id)
      if spot.nil?
        return render :new
      end
    end
    @report.spot = spot

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    @city = {
        :id => @report.spot.city.id,
        :display => "#{@report.spot.city.name}, #{@report.spot.city.county.state.two_digit_code}"
    }

    yelp_business_id = params[:report][:yelp_business_id]
    if yelp_business_id.blank?
      yelp_business_id = @report.spot.yelp_business_id
    end

    spot = Spot.where(yelp_business_id: yelp_business_id).first
    if spot.blank? then
      spot = get_spot_info(yelp_business_id)
      if spot.nil?
        @spot_on_yelp = {
            :id => @report.spot.yelp_business_id,
            :display => "#{@report.spot.name} (#{@report.spot.city.name})"
        }
        return render :edit
      end
    end
    update_params = report_params
    update_params[:spot] = spot

    if params[:report][:image].blank?
      update_params.delete(:image)
    end

    respond_to do |format|
      if @report.update(update_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  def ope_report_filter
    redirect_to :root if @report.user != current_user and current_user.right != ADMIN_RIGHT
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:title, :content, :image, :image_cache)
  end

  def get_spot_info(yelp_business_id)
    client = get_yelp_client
    response = client.business(yelp_business_id)
    if response.blank?
      return nil
    end

    zip = response.business.location.postal_code
    city = Zip.where(code: zip).first.city
    display_address = ""
    for address in response.business.location.display_address
      display_address += address
    end
    spot = Spot.new(
        :name => response.business.name,
        :city => city,
        :display_address => display_address,
        :latitude => response.business.location.coordinate.latitude,
        :longitude => response.business.location.coordinate.latitude,
        :yelp_url => response.business.url,
        :yelp_image_url => response.business.image_url,
        :yelp_business_id => yelp_business_id,
    )
    @spot_on_yelp = {
        :id => yelp_business_id,
        :display => "#{spot.name} (#{spot.city.name})"
    }
    return spot
  end

end
