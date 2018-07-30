class IssueSerializer < ActiveModel::Serializer
  attributes :id, :summary, :status, :reporter, :assignee
end