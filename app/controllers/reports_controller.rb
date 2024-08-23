class ReportsController < ApplicationController
  before_action :authenticate_user!


  def create
    debugger
    @report = Report.new(report_params)
    @report.user = current_user

    if @report.save

      redirect_to root_path, notice: 'Report was successfully submitted.'
    else
      redirect_to root_path, alert: 'Failed to submit report.'
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :reportable_id, :reportable_type)
  end


end
