Node-Linda-Base
===============

## config

    cp config/env.json.sample config/env.json

## tasks

### run as development mode

    make dev

### run as production mode

    make run

### build assets by grunt

    make build
    // or
    make watch

### run test

    make test

### foreman - manage process

    foreman start

### scaffold - 超simple generator

    $ ./bin/scaffold
    Usage: scaffold -t [type] -n [name]

      -t, --type  : event or model or helper
      -n, --name  : name of file

## Deploy on Heroku

    % heroku create
    % heroku labs:enable websockets
    % heroku config:set NODE_ENV=production
    % git push heroku master
    % heroku open

rename

    % heroku apps:rename YOUR-APP-NAME
