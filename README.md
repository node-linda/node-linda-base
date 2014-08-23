DEPRECATED
==========

This project was moved. Use `linda-server` in [linda](https://github.com/node-linda/linda)


Node-Linda-Base
===============

- [![Build Status](https://travis-ci.org/node-linda/node-linda-base.png?branch=master)](https://travis-ci.org/node-linda/node-linda-base)
- [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

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
    % heroku config:set NODE_ENV=production
    % git push heroku master
    % heroku open

rename your app

    % heroku apps:rename YOUR-APP-NAME

show logs on heroku

    % heroku config:set 'DEBUG=*'
    % heroku logs --tail
