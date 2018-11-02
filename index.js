const fs = require('fs');

const HolochainApp = require('./native').HolochainApp;

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