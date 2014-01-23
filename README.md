Node-Linda-Base
===============

[![Build Status](https://travis-ci.org/node-linda/node-linda-base.png?branch=master)](https://travis-ci.org/node-linda/node-linda-base)


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


Debug
-----

    % grunt
    % DEBUG=linda* grunt server

Deploy on Heroku
----------------

    % heroku create
    % heroku labs:enable websockets
    % heroku config:set NODE_ENV=production
    % git push heroku master
    % heroku open

rename your app

    % heroku apps:rename YOUR-APP-NAME

show logs on heroku

    % heroku config:set 'DEBUG=*'
    % heroku logs --tail
