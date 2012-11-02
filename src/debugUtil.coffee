root = this

window?.onerror = (message, url, lineNumber) ->
  msg = """An Error Occured on this page.
  Error: #{message}
  Url: #{url}
  Line: #{lineNumber}
  """
  console?.log msg

debugUtil =
  VERSION: "1.0.0"
  isBrowser:->
    window?

  loggingWrap: (self, func) ->
    orgFunc = func
    ->
      console?.log "Start #{func.name}"
      console?.log "arguments[#{i}] = #{arg}" for arg, i in arguments
      result = orgFunc.apply self, arguments
      console?.log "result = [#{result}]"
      result

  debugToScreen: (obj) ->
    # for client-side only
    if @isBrowser
      message = obj.toString()
      div = root.document.getElementById("debugOutput") || root.document.createElement("div")
      div.id = "debugOutput"
      logger = root.document.createElement("p")
      logger.innerHTML = message
      logger.setAttribute 'style',"background-color:whiteSmoke"
      logger.addEventListener 'click', ->
        div.removeChild(this)
      div.appendChild logger
      root.document.body.appendChild(div)

  getColorLogger:(prefix="Logger",level="debug",color="default") ->
    levels = {
      fatal : '[FATAL]'
      error : '[ERORR]'
      warn  : '[WARN]'
      info  : '[INFO]'
      debug : '[DEBUG]'
      trace : '[TRACE]'
    }
    colors = {
      black   : '\x1B[30m'
      red     : '\x1B[31m'
      green   : '\x1B[32m'
      yellow  : '\x1B[33m'
      blue    : '\x1B[34m'
      magenta : '\x1B[35m'
      cyan    : '\x1B[36m'
      white   : '\x1B[37m'
      default : '\x1B[39m'
      end     : '\x1B[39m'
    }
    if @isBrowser()
      for color,val of colors
        colors[color] = ""

    if not levels[level] then level = "debug"
    if not colors[color] then color = "default"

    l0Pad = (num) ->
      if num < 10 then "0" + num else num

    localeTime = ->
      date = new Date()
      ret = [
        date.getFullYear(), "-", l0Pad(date.getMonth() + 1), "-", l0Pad(date.getDate())
        " ",
        l0Pad(date.getHours()), ":", l0Pad(date.getMinutes()), ":", l0Pad(date.getSeconds())
      ]
      ret.join("")

    joinArguments = (arg) ->
      Array.prototype.join.apply arg, [" "]

    Logger = {
      prefix : "[#{prefix}]"
      level : level
      color : color

      setLevel : (level) ->
        @level = level

      setPrefix : (prefix) ->
        @prefix = "[ #{prefix} ]"
      
      setColor : (color) ->
        @color = color

      print : ->
        args = Array.prototype.slice.apply arguments
        args.unshift @prefix
        args.unshift localeTime()
        args.push colors["end"]
        console?.log args.join(" ")

      log : ->
        @print colors[@color],levels[@level],joinArguments(arguments)

      fatal : ->
        @print colors["red"],levels["fatal"],joinArguments(arguments)

      error : ->
        @print colors["red"],levels["error"],joinArguments(arguments)

      warn : ->
        @print colors["yellow"],levels["warn"],joinArguments(arguments)

      info : ->
        @print colors["cyan"],levels["info"],joinArguments(arguments)

      debug : ->
        @print colors["default"],levels["debug"],joinArguments(arguments)

      trace : ->
        @print colors["white"],levels["trace"],joinArguments(arguments)
    }

if typeof exports isnt 'undefined'
  if typeof module isnt 'undefined' and module.exports
    module.exports = debugUtil
  exports.debugUtil = debugUtil
else
  root["debugUtil"] = debugUtil
