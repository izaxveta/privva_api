class Issue < ApplicationRecord
  validates :summary, :status, presence: true
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id'
end