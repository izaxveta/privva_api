class Issue < ApplicationRecord
  validates :summary, :status, presence: true
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id'

  def self.find_by_summary(query)
    where('summary LIKE ?', "%#{query}%")
  end

  def self.handle_sort(query)
    order(query)
  end
end