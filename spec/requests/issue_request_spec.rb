require 'rails_helper'

RSpec.describe 'Issue API' do
  before(:each) do
    @user_1 = User.create(name: 'Sookie Stackhouse', email: 'sookie.stackhouse@mail.com')
    @user_2 = User.create(name: 'Bill Compton', email: 'bill.compton@mail.com')
    @user_3 = User.create(name: 'Eric Northman', email: 'eric.northman@mail.com')
    Issue.create(summary: 'Summary A', status: 0, reporter: @user_1, assignee: @user_2)
    Issue.create(summary: 'Summary B', status: 2, reporter: @user_2, assignee: @user_3)
    Issue.create(summary: 'Summary C', status: 1, reporter: @user_3, assignee: @user_1)
    Issue.create(summary: 'Summary D', status: 1, reporter: @user_2, assignee: @user_3)
  end

  it 'can return all issues' do
    get '/api/v1/issues'
    body = JSON.parse(response.body)
    issue_1 = body[0]

    expect(response.status).to eq(200)
    expect(body.count).to eq(4)
    expect(issue_1['summary']).to eq('Summary A')
    expect(issue_1['status']).to eq('created')
    expect(issue_1['reporter']['name']).to eq('Sookie Stackhouse')
    expect(issue_1['assignee']['name']).to eq('Bill Compton')
  end

  it 'can return all issues with summary attributes that match a given string' do
    get '/api/v1/issues?issue_summary=Summary B'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(1)
    expect(body.first['summary']).to eq('Summary B')
  end

  it 'can return all issues associated with a provided reporter name' do
    get '/api/v1/issues?reporter_name=Bill Compton'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(2)
    expect(body.first['reporter']['name']).to eq('Bill Compton')
  end

  it 'can return all issues associated with a provided assignee name' do
    get '/api/v1/issues?assignee_name=Eric Northman'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(2)
    expect(body.first['assignee']['name']).to eq('Eric Northman')
  end

  it 'can return all issues sorted by issue_summary' do
    get '/api/v1/issues?sort_order=summary'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(4)
    expect(body.first['summary']).to eq('Summary A')
    expect(body.last['summary']).to eq('Summary D')
  end

  it 'can return all issues sorted by issue_summary in reverse order' do
    get '/api/v1/issues?sort_order=summary DESC'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(4)
    expect(body.first['summary']).to eq('Summary D')
    expect(body.last['summary']).to eq('Summary A')
  end

  it 'can return all issues sorted by status based on issue lifecycle' do
    get '/api/v1/issues?sort_order=status'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(4)
    expect(body[0]['status']).to eq('created')
    expect(body[1]['status']).to eq('open')
    expect(body[2]['status']).to eq('open')
    expect(body[3]['status']).to eq('closed')
  end

  it 'can return all issues sorted by created_at' do
    get '/api/v1/issues?sort_order=created_at'
    body = JSON.parse(response.body)

    earliest_issue = Issue.first.created_at.strftime("%Y/%m/%d %H:%M:%S")
    latest_issue = Issue.last.created_at.strftime("%Y/%m/%d %H:%M:%S")

    expect(response.status).to eq(200)
    expect(body.count).to eq(4)
    expect(body.first['created_at']).to eq(earliest_issue)
    expect(body.last['created_at']).to eq(latest_issue)
  end

  it 'can return all issues paginated according to a given page_size' do
    get '/api/v1/issues?page_size=2'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(2)
    expect(Issue.count).to eq(4)
  end

  it 'can return a collection of issues paginated by page_size and index by given page number' do
    get '/api/v1/issues?page_size=3&&page=2'
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body.count).to eq(1)
    expect(Issue.count).to eq(4)
  end
end