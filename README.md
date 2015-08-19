![CircleCI](https://circleci.com/gh/Rykian/CineVOlle.svg?style=shield&circle-token=b2c64bdd56b588ca977e151958f93a669de2a9ca)

CineVOlle
=========

CineVOlle updates its users weekly with a list of undubbed foreign movies projected in the cinema Cineville, in the town of Laval.

Requirements
------------
* Docker
* Ruby 2.2.2

Installation
------------

* Create or reuse an existing docker machine (<https://docs.docker.com/machine/>)
* Launch PostgreSQL service in docker with Docker Compose: `docker-compose up`
* Launch Rails integrated server with `rails s`
* Go to <http://localhost:3000>

Configuration
-------------
Configuration could be done via environment variables or [Figaro](https://github.com/laserlemon/figaro).  
Configurable options are grouped into [config/application.example.yml](config/application.example.yml).

Rake tasks
----------

### Update theater sessions

Theater sessions is managed through [Allocine](http://allocine.fr) API. Update is launched by cron via a rake task. To launch update, type the following command in terminal :
```
rake cinevolle:update_screenings
```

### Sending newsletter

Newsletter is a rake task wich could be launched only on wednesday. It sends email only if there are screenings in the native-language version
Type the following command in terminal :
```
rake cinevolle:send_newsletter
```
