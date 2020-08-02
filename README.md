# Saúde Controlada API

API do site Saúde Controlada construído com [Ruby on Rails](https://rubyonrails.org/) como API e utilizando [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth).

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      2.6.6
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

[![CircleCI](https://circleci.com/gh/circleci/circleci-docs.svg?style=svg)](https://circleci.com/gh/circleci/circleci-docs)

Para rodar os testes:

```bash
rspec
```
