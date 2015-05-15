set :branch, ENV.fetch('BRANCH', 'master')
server "sim.demo.llp.pl",
  user: "lunar",
  roles: %w{web app db},
  port: 20022
set :port, 20022
