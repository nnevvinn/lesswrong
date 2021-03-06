load 'config/cap-tasks/trike-aws.rb'

set :application, "lesswrong.com"
set :domains, %w[ lesswrong.com ]

set :hosts, lambda { AWS.elb_hosts('python') }
role :app, *fetch(:hosts)
role :web, *fetch(:hosts)
role :db,  "db.aws.trike.com.au", :primary => true, :no_release => true
role :backups, "backup.trike.com.au", :user => 'backup', :no_release => true

before "deploy:update_code", "tests_check:manual_tests_executed?"

