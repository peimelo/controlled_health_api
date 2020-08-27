# Saúde Controlada API

API do site Saúde Controlada construído com [Ruby on Rails](https://rubyonrails.org/) como API e utilizando [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth).

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      2.7.1
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.0.3
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      Postgres
    </td>
  </tr>
</table>

O frontend desse repositório foi construído com Angular e se chama [saudecontrolada-frontend](https://github.com/peimelo/saudecontrolada-frontend).

## Configuração

```bash
git clone https://github.com/peimelo/saudecontrolada_api.git
cd saudecontrolada_api

# instalação das dependências
bundle

# criação do banco de dados e tabelas
rails db:create
rails db:migrate

# rodar o projeto
rails s
```

## Testes

[![CircleCI](https://circleci.com/gh/peimelo/saudecontrolada_api.svg?style=svg)](https://circleci.com/gh/peimelo/saudecontrolada_api)

Para rodar os testes:

```bash
rspec
```

## Configuração usando Docker

```bash
# subir as instâncias web e database
docker-compose up -d

# criação das tabelas
docker-compose exec web bundle exec rails db:migrate

# criação do banco de dados e tabelas de testes
docker-compose exec web bundle exec rails db:create RAILS_ENV=test
docker-compose exec web bundle exec rails db:migrate RAILS_ENV=test

# rodar os testes
docker-compose exec web bundle exec rspec

# parar as instâncias
docker-compose stop
```
