# debugUtil
Some debug utility for both server-side and client-side javascript.

## Install
### Server Side

```bash
npm install --save debug-util
```
and
```javascript
var debugUtil = require('debugUtil');
```
### Client Side

```html
<script src="/path/to/debugUtil.js"></script>
```

Client Side, `debugUtil` object is defined as `window.debugUtil`


## Usage
### getColorLogger(name,level,color)
```javascript
logger = debugUtil.getColorLogger("myLogger","info","cyan");
logger.log("message");
```
e.g.
this code will display like this
```javascript
defaultLogger = debugUtil.getColorLogger();
defaultLogger.log("This line is 'debug' level and color is 'default'");
defaultLogger.fatal("This line is 'fatal' level and color is 'red'");
defaultLogger.error("This line is 'error' level and color is 'red'");
defaultLogger.warn("This line is 'warn' level and color is 'yellow'");
defaultLogger.info("This line is 'info' level and color is 'cyan'");
defaultLogger.debug("This line is 'debug' level and color is 'default'");
defaultLogger.trace("This line is 'trace' level and color is 'white'");

//Set Name and Level
appLogger = debugUtil.getColorLogger("App","info");
appLogger.log("This line is 'info' level and color is 'default' and appender name is 'App'");

//Set Name, Level and Color
sysLogger = debugUtil.getColorLogger("Sys","warn","magenta");
sysLogger.log("This line is 'warn' level and color is 'magenta' and appender name is 'Sys'");
```
![Screen Shot](https://raw.github.com/georgeOsdDev/debugUtil/master/ScreenShot.png)

### loggingWrap(context,function)
```javascript
function sum(a,b){
  return a+b;
}
sum = debugUtil.loggingWrap(this,sum);
sum(1,2);
```
in your console
```
Start sum
arguments[0] = 1
arguments[1] = 2
result = [3]
```
### debugToScreen(String) *client side only
```javascript
debugUtil.debugToScreen("message");
```
message will append to `document.body` and will hide on click.



## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2012 [Takeharu.Oshida](http://georgeosddev.github.com)