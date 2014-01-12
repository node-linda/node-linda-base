Node-Linda-Base
===============


Demo
----

* http://node-linda-base.herokuapp.com


Install Dependencies
--------------------

    % npm install
    % npm install coffee-script grunt-cli -g


Config
------

    % cp config/env.json.sample config/env.json

Run
---

    % grunt build
    % make dev

=> http://localhost:3000


Deploy on Heroku
----------------

    % heroku create
    % heroku labs:enable websockets
    % heroku config:set NODE_ENV=production
    % git push heroku master
    % heroku open

rename your app

    % heroku apps:rename YOUR-APP-NAME
