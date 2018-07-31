class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  has_many :reported_issues, class_name: 'Issue', foreign_key: 'reporter_id'
  has_many :assigned_issues, class_name: 'Issue', foreign_key: 'assignee_id'

  def self.reported_issues(user_name)
    find_by(name: user_name).reported_issues
  end

  def self.assigned_issues(user_name)
    find_by(name: user_name).assigned_issues
  end
end