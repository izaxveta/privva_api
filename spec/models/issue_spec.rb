require 'rails_helper'

RSpec.describe 'Issue' do
  describe 'validations' do
    context 'invalid attributes' do
      @reporter = User.create(name: 'Mary Anne', email: 'mary.anne@mail.com')
      @assignee = User.create(name: 'John Doe', email: 'john.doe@mail.com')

      it 'is invalid without a reporter' do
        issue = Issue.create(
          summary: '',
          status: '',
          assignee: assignee
        )

        expect(issue).to be_invalid
      end
    end
  end
end

# issue has summary, status, reporter, and assignee