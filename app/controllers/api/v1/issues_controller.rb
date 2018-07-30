class Api::V1::IssuesController < ApplicationController
  def index
    issues = handle_queries(params)
    render status: 200, json: issues
  end

  private
    def handle_queries(params)
      return Issue.find_by_summary(params[:issue_summary]) if params[:issue_summary]
      return User.reported_issues(params[:reporter_name]) if params[:reporter_name]
      return User.assigned_issues(params[:assignee_name]) if params[:assignee_name]
      return Issue.handle_sort(params[:sort_order]) if params[:sort_order]
      return Issue.all
    end
end