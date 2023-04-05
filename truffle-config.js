require('babel-register');
require('babel-polyfill');
require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');
var mnemonic = process.env["MNEMONIC"];
var tokenKey = process.env["INFURA_KEY"];
const URL = 'https://rpc.roxycoin.be/';

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: 5777 // Match any network id
    },
    roxycoin: {
      networkCheckTimeout: 10000,
      provider:function() {return new HDWalletProvider(mnemonic, URL);
      },
      network_id: '*',
      gas: 4700000,
      }
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
}
