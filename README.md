# README

### Ruby version: 2.6.6
### Rails version: 6.0.3.6

### Postgres version: 12.x

### Gem using:
- Devise: for basic authentication flow
- Pagy: pagination

### 3rd party using:
- Heroku: Cloud platform

### Heroku production
https://obscure-reaches-08264.herokuapp.com/

### Environment configuration
```
CHAT_IDS=chat_id_1,chat_id_2
BOT_TOKEN=yourbottoken
BOT_NAME=yourbotname
BOT_USERNAME=yourbotusername
DB_USER=yourdbuser
DB_NAME=yourdbname
DB_PASSWORD=yourdbpassword
DB_HOST=yourdbhost
DB_PORT=yourdbport
EXCHANGE_RATE_API_KEY=yourexchangerateapi
```

### Setup guide
1. create `.env` on root directory follow `sample.env` file
2. run `rake db:create` command to create database
3. run `rake db:migrate` command to run migration
4. run `rake db:seed` command to generate dump data
5. run `rails s` command to start server
