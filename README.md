# holochain-nodejs

[![Build Status](https://travis-ci.com/holochain/holochain-nodejs.svg?branch=master)](https://travis-ci.com/holochain/holochain-nodejs)

Node bindings for holochain

## Installation

The recommended way to install is via npm https://www.npmjs.com/package/@holochain/holochain-nodejs.

To build from source clone the repo and run
```
node ./publish.js
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

## Authors

- Julian Laubstein <contact@julianlaubstein.de>
- Willem Olding <willem.olding@holo.host>

## Acknowledgments

- Thanks to IronCoreLabs for the example of deploying neon modules via npm (https://github.com/IronCoreLabs/recrypt-node-binding)
