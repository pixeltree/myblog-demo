## Set up the application

```
rails new myblog --skip-test
# Creates a new rails app, installs the gems
cd myblog

bundle exec rails webpacker:install
rails server

```

## Add RSpec

Add to Gemfile in the :development, :test group
```   
gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: 'v4.0.0.beta3'
gem 'faker'
gem 'factory_bot_rails'
gem 'shoulda-matchers'
gem 'rails-controller-testing'
```

```
rails g spec:install
```

Add to the bottom of rails_helper.rb
```
config.include Devise::Test::ControllerHelpers, type: :controller
config.include Devise::Test::ControllerHelpers, type: :view
config.include Devise::Test::IntegrationHelpers, type: :request
```

Add to rails_helper.rb, right above RSpec.configure

```
Shoulda::Matchers.configure do |config|
 config.integrate do |with|
   # Choose a test framework:
   with.test_framework :rspec

   # Choose one or more libraries:
   with.library :rails
 end
end
```

## Generate welcome controller

```
rails generate controller welcome index
```

## Add Devise Authentication

https://github.com/plataformatec/devise

Add to Gemfile
```
gem 'devise'
```

```
rails generate devise:install
```

Add to development.rb

```
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

```
rails generate devise user
```

Add to ApplicationController
```
before_action :authenticate_user!
```

Add to bottom of rails_helper.rb

```
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
end
```

Update spec/factories/users.rb
```
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex }
  end
end
```

Add to controllers for authentication

```
before { sign_in FactoryBot.create(:user) }
```

## Create Posts

```
rails generate scaffold post title:string body:text

```

Update posts/index.html.erb

```
<% @posts.each do |post| %>
  <h1><%= post.title %></h1>

  <%= simple_format post.body %>
  <hr/>
<% end %>

<%= link_to 'New Post', new_post_path %>
```
