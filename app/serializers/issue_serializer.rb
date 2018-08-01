class IssueSerializer < ActiveModel::Serializer
  attributes :id, :summary, :status, :created_at, :updated_at

  belongs_to :reporter
  belongs_to :assignee

  def created_at
    object.created_at.strftime("%Y/%m/%d %H:%M:%S")
  end

  def updated_at
    object.updated_at.strftime("%Y/%m/%d %H:%M:%S")
  end
end