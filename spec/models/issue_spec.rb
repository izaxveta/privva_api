require 'rails_helper'

RSpec.describe Issue, type: :model do
  context 'validations' do
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:status) }
    it do
      should define_enum_for(:status).with([:created, :open, :closed, :archived])
    end
  end

  context 'relationships' do
    it { should belong_to(:reporter) }
    it { should belong_to(:assignee) }
  end

  context 'methods' do
    before :all do
      reporter_1 = User.create!(name: 'Eric Northman', email: 'eric.northman@mail.com')
      reporter_2 = User.create!(name: 'Bill Compton', email: 'bill.compton@mail.com')
      assignee_1 = User.create!(name: 'Pam Beaufort', email: 'pam.beaufort@mail.com')
      @issue_1 = Issue.create!(summary: 'Sample summary 1', status: 0, reporter: reporter_1, assignee: assignee_1)
      @issue_2 = Issue.create!(summary: 'Sample summary 2', status: 1, reporter: reporter_2, assignee: assignee_1)
    end

    it '.find_by_summary should return issues whose summaries contain a given string' do
      subject = Issue.find_by_summary('summary 1')
      expect(subject.first).to eq(@issue_1)
    end

    it '.handle_sort can sort all issues by summaries descending' do
      subject = Issue.handle_sort('summary DESC')
      expect(subject.first).to eq(@issue_2)
      expect(subject.last).to eq(@issue_1)
    end

    it '.handle_sort can sort all issues by summaries ascending' do
      subject = Issue.handle_sort('summary')
      expect(subject.first).to eq(@issue_1)
      expect(subject.last).to eq(@issue_2)
    end

    it '.handle_sort can sort all issues by status descending' do
      subject = Issue.handle_sort('status DESC')
      expect(subject.first).to eq(@issue_2)
      expect(subject.last).to eq(@issue_1)
    end

    it '.handle_sort can sort all issues by status ascending' do
      subject = Issue.handle_sort('status')
      expect(subject.first).to eq(@issue_1)
      expect(subject.last).to eq(@issue_2)
    end

    it '.handle_sort can sort all issues by created_at descending' do
      subject = Issue.handle_sort('created_at DESC')
      expect(subject.first).to eq(@issue_2)
      expect(subject.last).to eq(@issue_1)
    end

    it '.handle_sort can sort all issues by created_at ascending' do
      subject = Issue.handle_sort('created_at')
      expect(subject.first).to eq(@issue_1)
      expect(subject.last).to eq(@issue_2)
    end
  end
end