class ReportsController < ApplicationController
  before_filter :require_login, :only => [:edit, :update, :destroy]
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
    @city = current_user.city
  end

  # GET /reports/1/edit
  def edit
    @city = @report.spot.city
    @spot_on_yelp = {
        :id => @report.spot.id,
        :display => "#{@report.spot.name} (#{@report.spot.city.name})"
    }
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user = current_user

    yelp_business_id = params['report']['yelp_business_id']
    spot = Spot.where(yelp_business_id: yelp_business_id)
    if spot.blank? then
      client = get_yelp_client
      response = client.business(yelp_business_id)
      zip = response.business.location.postal_code
      city = Zip.where(code: zip).first.city
      spot = Spot.new(
          :name => response.business.name,
          :city => city,
          :display_address => response.business.location.display_address,
          :latitude => response.business.location.coordinate.latitude,
          :longitude => response.business.location.coordinate.latitude,
          :yelp_url => response.business.url,
          :yelp_image_url => response.business.image_url,
          :yelp_business_id => yelp_business_id,
      )
      @report.spot = spot
    else
      @report.spot = spot
    end

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
    respond_to do |format|
      if @report.update(report_params)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:title, :content, :image, :image_cache)
    end
end
