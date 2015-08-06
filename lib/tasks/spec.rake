require 'yaml'

namespace :spec do
  desc 'Run all tests that are run on CI (ruby, javascript, integration)'
  task :run_all do
    commands = YAML.load_file('circle.yml')['test']['override']

    statuses = commands.map { |command| system(command) }
    exit 1 unless statuses.all?
  end
end
