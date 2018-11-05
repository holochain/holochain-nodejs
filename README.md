# holochain-nodejs

Node bindings for holochain

## Installation

The reccomended way to install is via npm https://www.npmjs.com/package/@holochain/holochain-nodejs.

To build from source clone the repo and run
```
npm ./publish.js
```
from the project root.

## Usage
After installing via npm the module can be used in a node script as follows:

```javascript
const Container = require('@holochain/holochain-nodejs');
const app = Container.loadAndInstantiate("path/to/happ.hcpkg");
app.start();

// make calls to the app instance
// zome functions can be called using
// app.call(zome, capability, function, params);

app.stop();
```

See also the example directory

## Deployment

Tagging the master branch with the format `vX.X.X` will cause the CI to build for all platforms, upload the binaries to github releases and publish the package to npm.
