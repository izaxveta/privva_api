if Rails.env.development?
  reporters = []
  reporters << User.create(name: 'Jessica Hamby', email: 'jessica.hamby@mail.com')
  reporters << User.create(name: 'Bill Compton', email: 'bill.compton@mail.com')
  reporters << User.create(name: 'Eric Northman', email: 'eric.northman@mail.com')
  reporters << User.create(name: 'Pam Beaufort', email: 'pam.beaufort@mail.com')
  assignees = []
  assignees << User.create(name: 'Sookie Stackhouse', email: 'sookie.stackhouse@mail.com')
  assignees << User.create(name: 'Tara Thornton', email: 'tara.thornton@mail.com')
  assignees << User.create(name: 'Sam Merlotte', email: 'sam.merlotte@mail.com')
  assignees << User.create(name: 'Lafayette Reynolds', email: 'lafayette.reynolds@mail.com')

  puts "-- Successfully created #{User.count}/8 Users."

  summary = ['summary a', 'summary b', 'summary c', 'summary d', 'summary e', 'summary f']
  status = ['ACTIVE', 'INACTIVE', 'CLOSED', 'RESOLVED']

  100.times do
    issue = Issue.create(summary: summary.sample, status: status.sample, reporter: reporters.sample, assignee: assignees.sample )
    puts "Creating issue #{issue.id}"
  end

  puts "-- Successfully created #{Issue.count}/100 Issues."
end