# Controlled Health API

Controlled Health website API built with [Ruby on Rails](https://rubyonrails.org/) as API and using [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth).

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      2.7.2
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.0.3.4
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      PostgreSQL
    </td>
  </tr>
</table>

The frontend of this repository was built with Angular and is called [controlled-health-frontend](https://github.com/peimelo/controlled-health-frontend).

## Configuration

```bash
git clone https://github.com/peimelo/controlled_health_api.git
cd controlled_health_api

# installation of dependencies
bundle install

# creation of database and tables
rails db:create
rails db:migrate

# run the project
rails s
```

## Configuration for Production

```bash
# delete the config/credentials.yml.enc file
rm config/credentials.yml.enc

# run the command to create credentials and master key (replace 'code' if you don't use VS Code)
EDITOR = "code --wait" bin / rails credentials: edit
```

Add the information below to configure the email used by the Devise
gem and frontend host (replace with the values ​​you want):

```yml
# ... your content above

gmail:
  user_name: your@email.com
  password: your_password

frontend:
  dev: http://localhost:your_port
  prod: https://your_site.com
```

Save and close the `config/credentials.yml.enc` file.

If you want to use another email provider, change it in the file
`config/environments/production.rb`.

If you want to use another `default_confirm_success_url`, change it in the file
`config/initializers/devise_token_auth.rb`.

## Tests

[![CircleCI](https://circleci.com/gh/peimelo/controlled_health_api.svg?style=svg)](https://circleci.com/gh/peimelo/controlled_health_api)

To run the tests:

```bash
bundle exec rspec
```

## Configuration to use Docker

```bash
# upload the web and database instances
docker-compose up -d

# creation of tables
docker-compose exec web bundle exec rails db:migrate

# creation of database and test tables
docker-compose exec web bundle exec rails db:create RAILS_ENV=test
docker-compose exec web bundle exec rails db:migrate RAILS_ENV=test

# run the tests
docker-compose exec web bundle exec rspec

# stop the instances
docker-compose stop
```
