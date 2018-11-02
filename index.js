
var binary = require('node-pre-gyp');
const fs = require('fs');
var path = require('path')

// deals with ensuring the correct version for the machine/node version
var binding_path = binary.find(path.resolve(path.join(__dirname,'./package.json')));

var HolochainApp = require(binding_path).HolochainApp;

module.exports = {
  loadAndInstantiate: function(fileName) {
    const content = fs.readFileSync(fileName);
    const jsonContent = JSON.parse(content);
    const jsonString = JSON.stringify(jsonContent);

    let app;
    try {
      app = new HolochainApp("bob", jsonString);
    } catch (e) {
      console.log("Unable to create Holochain instance");
      throw e;
    }

    return app;
  }
};