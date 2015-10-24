class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]

  def index
    if params.has_key?("location_id")
      @reports = Report.where(:location_id => params["location_id"])
    else
      @reports = Report.all 
    end
    render json: @reports
  end

  def show
    render json: @report
  end

  def create
    @report = Report.new(report_params)

    lat = params[:latitude]
    long = params[:longitude]
    p = RGeo::Cartesian.factory.point(long, lat)
    @report.geolocation = p

    if @report.save
      render json: @report, status: :created, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.permit(:created_at, :image, :blurb, :location_id, :animal_id)
  end
end
