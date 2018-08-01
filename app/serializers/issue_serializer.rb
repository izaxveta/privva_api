class IssueSerializer < ActiveModel::Serializer
  attributes :id, :summary, :status, :created_at, :updated_at

  belongs_to :reporter
  belongs_to :assignee

  def created_at
    object.created_at.strftime("%m/%d/%Y %I:%M%p")
  end

  def updated_at
    object.updated_at.strftime("%m/%d/%Y %I:%M%p")
  end
end