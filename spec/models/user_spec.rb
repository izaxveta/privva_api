require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('john.doe@mail.com').for(:email) }
    it { should_not allow_value('john.doe.at.mail.com').for(:email) }
  end

  context 'relationships' do
    it { should have_many(:reported_issues) }
    it { should have_many(:assigned_issues) }
  end

  context 'method' do
    before :all do
      @reporter_1 = User.create!(name: 'Eric Northman', email: 'eric.northman@mail.com')
      @reporter_2 = User.create!(name: 'Bill Compton', email: 'bill.compton@mail.com')
      @assignee_1 = User.create!(name: 'Pam Beaufort', email: 'pam.beaufort@mail.com')
      @assignee_2 = User.create!(name: 'Jessica Hamby', email: 'jessica.hamby@mail.com')
      Issue.create!(summary: 'Sample summary', status: 'ACTIVE', reporter: @reporter_1, assignee: @assignee_1)
      Issue.create!(summary: 'Sample summary', status: 'ACTIVE', reporter: @reporter_2, assignee: @assignee_1)
      Issue.create!(summary: 'Sample summary', status: 'ACTIVE', reporter: @reporter_1, assignee: @assignee_1)
      Issue.create!(summary: 'Sample summary', status: 'ACTIVE', reporter: @reporter_2, assignee: @assignee_2)
    end

    it '.reported_issues returns all associated reported issues given a user' do
      actual = User.reported_issues(@reporter_1.name)
      expect(actual.count).to eq(2)
      expect(actual).to eq(@reporter_1.reported_issues)
      expect(actual[0].reporter.email).to eq(@reporter_1.email)
      expect(actual[1].reporter.email).to eq(@reporter_1.email)
    end

    it '.assigned_issues returns all associated assigned issues given a user' do
      actual = User.assigned_issues(@assignee_1.name)
      expect(actual.count).to eq(3)
      expect(actual).to eq(@assignee_1.assigned_issues)
      expect(actual[0].assignee.email).to eq(@assignee_1.email)
      expect(actual[1].assignee.email).to eq(@assignee_1.email)
      expect(actual[2].assignee.email).to eq(@assignee_1.email)
    end
  end
end