debug = require('debug')('coah:helper:-a')
path = require 'path'
child_process = require 'child_process'

process.version = require(path.resolve 'package.json').version
