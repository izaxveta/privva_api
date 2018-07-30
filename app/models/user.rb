class User < ApplicationRecord
  validates :name, :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  has_many :reported_issues, class_name: 'Issue', foreign_key: 'reporter_id'
  has_many :assigned_issues, class_name: 'Issue', foreign_key: 'assignee_id'
end