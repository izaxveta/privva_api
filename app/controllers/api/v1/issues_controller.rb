class Api::V1::IssuesController < ApplicationController
  def index
    render status: 200, json: Issue.all
  end
end