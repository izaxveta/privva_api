require 'rails_helper'

RSpec.describe 'Issue API' do
  before(:each) do
    @user_1 = User.create(name: 'John Doe', email: 'john.doe@mail.com')
    @user_2 = User.create(name: 'Mary Anne', email: 'mary.anne@mail.com')
    @user_3 = User.create(name: 'Anna Sui', email: 'anna.sui@mail.com')
    Issue.create(summary: 'Hello world', status: 'Active', reporter: @user_1, assignee: @user_2)
    Issue.create(summary: 'Hello world', status: 'Active', reporter: @user_2, assignee: @user_3)
    Issue.create(summary: 'Hello world', status: 'Active', reporter: @user_3, assignee: @user_1)
  end

  it 'can return all issues' do
    get '/api/v1/issues'

    body = JSON.parse(response.body)
    issue_1 = body[0]
    issue_2 = body[1]
    issue_3 = body[2]

    expect(response.status).to eq(200)
    expect(body.count).to eq(3)
    expect(issue_1['summary']).to eq('Hello world')
    expect(issue_1['status']).to eq('Active')
    expect(issue_1['reporter']['name']).to eq('John Doe')
    expect(issue_1['assignee']['name']).to eq('Mary Anne')
  end
end