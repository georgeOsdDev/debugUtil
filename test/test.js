var debugUtil = require("../lib/debugUtil"),
// var debugUtil = require("debug-util"),
    assert    = require("assert");

console.log("- Test of debugUtil.isBrowser() -");
assert.equal(debugUtil.isBrowser(), false, ["Run in Node.js, isBrowser == false"])
console.log("");

//Get Default Logger
console.log("- Test of debugUtil.getColorLogger() -");
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
console.log("");

console.log("- Test of debugUtil.loggingWrap() -");
//Named function
function sum(a,b){
  return a+b;
}
sum = debugUtil.loggingWrap(this,sum);
sum(1,2);

//Anonymous function
double = function(a){
  return a*2;
}
double = debugUtil.loggingWrap(this,double);
double(1,2);

//Anonymous function with name
foo = function inclement(a){
  return a+1;
}
foo = debugUtil.loggingWrap(this,foo);
foo(1,2);
console.log("");