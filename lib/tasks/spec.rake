require 'yaml'

namespace :spec do
  desc "Run all tests that are run on CI (ruby, javascript, integration)"
  task :run_all do
    commands = YAML.load_file('circle.yml')['test']['override']

    success = true
    commands.each do |command|
      success = system(command)
    end
    fail "Some tests failed" unless success
  end
end
