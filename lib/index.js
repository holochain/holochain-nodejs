var fs = require('fs');

var native = require('../native');
var HolochainApp = native.HolochainApp;

var app;
try {
  var app = new HolochainApp("bob", "{}");
} catch (e) {
  console.log("Unable to create Holochain instance");
  return;
}

app.start();
