## SIM

Search in MENA

#### Project setup

Make sure that you have java jdk. You can download it from here: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html.

```
cp config/database.yml.example config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate

cp config/pre-push .git/hooks/pre-push

brew install node
npm install

npm run update-webdriver

bundle exec rake bower:install

bundle exec rails s
```

#### Running tests

Run all tests

```
bundle exec rake spec:run_all
```

##### Rspec (ruby unit tests)

```
bundle exec rspec spec
```

##### Jasmine (javascript tests)

```
npm run karma
```

Or if you prefer browser view go to: http://localhost:3000/specs

Tests located in `spec/javascripts/unit`.

More info: [Jasmine doc](http://jasmine.github.io/1.3/introduction.html)

##### Protractor (integration tests)

First time you need to run:

```
npm run update-webdriver
```

Then you can just start protactor server (in some different tab):

```
npm run start-webdriver
```

And run tests with:

```
npm run protractor
```

*Note: you need to have rails appliction running.*

Tests located in `spec/javascripts/e2e`.

More info: [Protractor docs](http://angular.github.io/protractor/#/tutorial)

##### Using guard

For ruby unit tests you can use [guard](https://github.com/guard/guard).
It's a separate process which you can keep visible on one of your screens. It monitors the files and automatically runs related unit tests as soon as you save a file.

To run it just type:

```
bundle exec guard start
```

It works only for ruby tests (yet). There is no way for running protractor tests like that yet, but you can use `npm run test` for karma tests.

#### Services

General most imporant rule - try to create small classes with one responsibility (Single Responsibility Principle).
So for example you might have a case where a lot of code in your controller should actually go somewhere else. The best way is to create service (or even more than one if one is getting too big).

Place them in `app/services` directory.

Example:

```ruby
class SampleService
  attr_accessor :another_sample_service, :user_repository
  
  def initialize(another_sample_service, user_repository)
    self.another_sample_service = another_sample_service
    self.user_repository = user_repository
  end

  def perform(user_id)
    user = user_repository.find_by_id(user_id)
    response = another_sample_service.perform(user)

    return response unless response.successful?

    important_thing = response.object

    # some short logic or call to another service if more logic needed
    # important_thing = ...

    Response.new(success: true, object: important_thing)
  end
end
```

#### Dependor

We should try to think about building application as if we were building it from small boxes that use each other. So we should create lots of small services (as mentioned above). To make them use each other, we need to inject responsibilities somehow.
We can do this just by passing other service in the `initialize` method. But we can also use `dependor`, which automates that for us.

See above example with using `dependor`:

```ruby
class SampleService
  takes :another_sample_service, :user_repository

  def perform(user_id)
    user = user_repository.find_by_id(user_id)
    response = another_sample_service.perform(user)

    return response unless response.successful?

    important_thing = response.object

    # some short logic or call to another service if more logic needed
    # important_thing = ...

    Response.new(success: true, object: important_thing)
  end
end
```

Generally we should try to use `takes` whenever possible. But sometimes it's not possible (for example in controllers you don't have control over creating controller instance and you cannot just change it's initializer) - in such cases you can use `inject`.

See more info [here](https://github.com/psyho/dependor).

#### Write tests

As a general rule we should try to implement tests for everything.
We have [rcov](https://github.com/relevance/rcov) setup to measure ruby code coverage - you can see percentage after running ruby test suite (`rspec spec`).
But of course it doesn't mean that we need to test every line just to have test - let's try to be reasonable and have meaningful, and more importantly useful tests.

Example test for above service:

```ruby
require 'rails_helper'

describe SampleService do
  describe "#perform" do
    let(:service) { SampleService.new(another_sample_service, user_repository) }

    # useful bogus helper, creates something like rspec's double
    # but with all the methods which another_sample_service should have stubbed
    fake(:another_sample_service)

    # sometimes you can stub repository, sometimes test makes more sens, when
    # you use real one:
    # let(:user_repository) { UserRepository.new }
    fake(:user_repository)

    # useful method from factory_girl when we have User model and user factory
    # let(:user) { build(:user) }
    # let(:user_id) { user.id }
    #
    # or just rspec's double if you don't need model here
    let(:user) { double }
    let(:user_id) { 7 }

    subject { service.perform(user_id) }

    before do
      expect(another_sample_service).to receive(:perform)
        .and_return(Response.new(success: success))
    end

    context "another service returns success" do
      let(:success) { true }

      it { expect(subject.successful?).to be true }

      # more tests...
    end

    context "another service returns error" do
      let(:success) { false }

      it { expect(subject.successful?).to be false }

      # more tests...
    end
  end
end
```

#### Repositories

We decided to follow Repository Pattern, so we will use repositories everywhere when you normally would use `ActiveRecord` models.
Repositories are just wrappers for them, so code doesn't rely on `ActiveRecord` and all the domain specific methods can be placed in repositories, leaving models as pure database related beings.

Example:

```ruby
class UserRepository < AbstractRepository
  def claim_profile(user, profile)
    return false if profile.user

    profile.status = Profile::STATUSES[:claimed]
    user.profiles << profile
    user.save
  end

  def generate_api_token(user)
    token = loop do
      token = Devise.friendly_token
      break token unless klass.where(api_token: token).first
    end
    user.api_token = token
    user.save
  end

  def find_by_api_token(api_token)
    klass.find_by_api_token(api_token)
  end
end
```

Every model should have it's repository. To create one, just create a class which inherites from `AbstractRepository` and place it in `app/repositories` directory.

As mentioned before, every `CRUD` operation should be done using repository, not pure model, so e. g. when you need to find user instead of doing it like that:

```ruby
user = User.find_by_id(params[:id])
```

Use repository:

```ruby
user = user_repository.find_by_id(params[:id])
```

#### Rendering views

Try to avoid using `@ivars` (instance variables) in views.
Render view explicitly at the end of controller action, passing all variables as local ones.
This way it's clearer what the view depends on.

E. g.:

```ruby
user = user_repository.find_by_id(params[:id])
render :show, locals: { user: user }
```

#### Presenters

Try to extract all presentation related things to presenters - if you have lots of things to display in a view (or some trivial computation to make, like combining name and surname to full name or formatting date/price), group them in presenters - simple classes in `app/presenters` directory.

E .g.:

```ruby
  class UserPresenter
    attr_accessor :user
    
    def initialize(user)
      self.user = user
    end
    
    def full_name
      "#{user.name} #{user.surname}"
    end
  end
```

And then in view:

```
user = user_repository.find_by_id(params[:id])
render :show, locals: { user: UserPresenter.new(user) }
```

#### Angular

Directory structure (`app/assets/javascripts`):

- `application.js` - requires with proper order
- `controllers` - directory with controllers, sample controller:

```coffee
@Sim.controller 'DashboardCtrl', ['$scope', 'sampleService',
  ($scope, sampleService) ->
    $scope.test = "Hello world! " + sampleService.randomNumber()
]
```
And test for it (in `spec/javascripts/unit/services/sample_service_spec.coffee`

```coffee
describe "sampleService", ->
  _sampleService = null

  beforeEach ->
    angular.mock.module('sim')
    inject (sampleService) ->
      _sampleService = sampleService

  describe "randomNumber", ->
    it "returns 4", ->
      expect(_sampleService.randomNumber()).toEqual(4)
```

- `router.coffee` - routing for the js part of the app
- `sim.coffee` - definition of the `@Sim` app and all modules it needs 
- `services` - directory with controllers, sample service:

```coffee
@Sim.service "sampleService", ->
  randomNumber: ->
    4 # ;)
```
- `templates` - templates, example template:
```haml
%h1
  Hi, Search in MENA here
{{ test }}
```

#### Useful resources

- [Great Angular Tutorial, must read](https://thinkster.io/angular-rails/)
- [Good Anguar Practises](https://teamgaslight.com/blog/4-lessons-learned-doing-angular-on-rails)
- [Really good protractor Overview](http://ramonvictor.github.io/protractor/slides/#/52)

