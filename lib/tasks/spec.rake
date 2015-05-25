namespace :spec do
  desc "Run all tests (ruby, javascript, integration)"
  task run_all: :environment do
    commands = [
      "bundle exec rspec --color --require spec_helper spec --format progress",
      "npm run karma",
      "npm run protractor",
      "bundle exec rubocop",
      "bundle exec haml-lint app/views/ -e app/views/layouts/_head.html.haml"
    ]

    success = true
    commands.each do |command|
      success = system(command)
    end
    fail "Some tests failed" unless success
  end
end
