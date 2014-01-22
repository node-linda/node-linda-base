Node-Linda-Base
===============

[![Travis-CI Build status](https://travis-ci.org/node-linda/node-linda-base.png)](https://travis-ci.org/node-linda/node-linda-base)


Demo
----

* http://node-linda-base.herokuapp.com


Install Dependencies
--------------------

    % npm install
    % npm install coffee-script grunt-cli -g


Run
---

    % grunt build
    % grunt server

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
