log = console.log
crypto = require 'crypto'
{ exec } = require 'child_process'

Coffee =
  cmd: "coffee"         
  options: [
    "-c"                                #compile option
    "-o ./lib"                          #dest
    "./src/debugUtil.coffee"            #src
  ]

Coffeelint =
  cmd: "coffeelint"
  options: [
    "-f ./test/coffeelint.json"         #config file
    "-r"                                #recurisve
    "./"                                #src
  ]

Uglifyjs =
  cmd: "uglifyjs"
  options: [
    "--verbose"                         #verbose
    "--overwrite"                       #overwrite
    "./lib/debugUtil.js"                #src
  ]

task 'compile', (options) ->
  execGlobalCommand(Coffeelint)
  execGlobalCommand(Coffee)
  # execGlobalCommand(Stylus)

task 'uglify', (options) ->
  execGlobalCommand(Uglifyjs)

task 'lint', (options) ->
  execGlobalCommand(Coffeelint)

task 'test', (options) ->
  exec "node ./test/test.js", (err, stdout, stderr)->
    log stdout + stderr

task 'clean', (options) ->
  clean()

execGlobalCommand = (command) ->
  exec "#{command.cmd} #{command.options.join(' ')}", (err, stdout, stderr)->
    log stdout + stderr
    if (command.callback)
      exec "#{command.callback}", (err, stdout, stderr)->
        log stdout + stderr

clean = ->
  exec 'rm -rf ./lib/*.js', (err, stdout, stderr)->
    throw err if err
    log stdout + stderr
