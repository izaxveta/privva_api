require 'rails_helper'

RSpec.describe 'Issue' do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a summary' do
        reporter = User.create(name: 'Mary Anne', email: 'mary.anne@mail.com')
        assignee = User.create(name: 'John Doe', email: 'john.doe@mail.com')
        issue = Issue.create(
          status: 'Active',
          reporter: reporter,
          assignee: assignee
        )

        expect(issue).to be_invalid
      end

      it 'is invalid without a status' do
        reporter = User.create(name: 'Mary Anne', email: 'mary.anne@mail.com')
        assignee = User.create(name: 'John Doe', email: 'john.doe@mail.com')
        issue = Issue.create(
          summary: 'Hello World',
          reporter: reporter,
          assignee: assignee
        )

        expect(issue).to be_invalid
      end

      it 'is invalid without a reporter' do
        assignee = User.create(name: 'John Doe', email: 'john.doe@mail.com')
        issue = Issue.create(
          summary: 'Hello world',
          status: 'Active',
          assignee: assignee
        )

        expect(issue).to be_invalid
      end

      it 'is invalid without an assignee' do
        reporter = User.create(name: 'Mary Anne', email: 'mary.anne@mail.com')
        issue = Issue.create(
          summary: 'Hello world',
          status: 'Active',
          reporter: reporter
        )

        expect(issue).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a summary, status, reporter, and assignee' do
        reporter = User.create(name: 'Mary Anne', email: 'mary.anne@mail.com')
        assignee = User.create(name: 'John Doe', email: 'john.doe@mail.com')
        issue = Issue.create(
          summary: 'Hello World',
          status: 'Active',
          reporter: reporter,
          assignee: assignee
        )

        expect(issue).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to a User reporter' do
      relation = Issue.reflect_on_association(:reporter)
      expect(relation.macro).to eq(:belongs_to)
    end

    it 'belongs to a User assignee' do
      relation = Issue.reflect_on_association(:assignee)
      expect(relation.macro).to eq(:belongs_to)
    end
  end
end

# issue has summary, status, reporter, and assignee