class ReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reportable = find_reportable
    @report = @reportable.reports.new(report_params)
    @report.user = current_user

    if @report.save
      redirect_to @reportable, notice: 'Report was successfully submitted.'
    else
      redirect_to @reportable, alert: 'Failed to submit report.'
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end

  def find_reportable
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end
end
