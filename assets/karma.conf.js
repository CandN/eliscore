var webpack = require('webpack');
var path = require('path');
console.log(path.resolve(__dirname, 'node_modules'));

module.exports = function (config) {
  config.set({
    basePath: '.',
    browsers: [ 'Chrome' ], //run in Chrome
    singleRun: true, //just run once by default
    frameworks: [ 'mocha' ], //use the mocha test framework
    files: [
      'tests.webpack.js' //just load this file
    ],
    preprocessors: {
      'tests.webpack.js': [ 'webpack', 'sourcemap', 'babel' ] //preprocess with webpack and our sourcemap loader
    },
    reporters: [ 'dots' ], //report results in this format
    webpack: { //kind of a copy of your webpack config
      devtool: 'inline-source-map', //just do inline source maps instead of the default
      context: path.resolve(__dirname),
      module: {
        loaders: [
          {
            test: /\.js$/,
            exclude: /(node_modules)/,
            loader: "babel-loader",
            query: {
              presets: ["babel-preset-es2015", "react", "stage-0", "stage-2"]
            }
          },
          { test: /\.json$/, loader: 'json' },
          {
            test: /\.jsx?$/,
            exclude: /(node_modules)/,
            loader: "babel-loader",
            query: {
              presets: ["es2015", "react", "stage-0", "stage-2"]
            }
          }
        ]
      },
      externals: {
        'react/lib/ReactContext': true,
        'jsdom': 'window',
        'cheerio': 'window',
        'react/lib/ExecutionEnvironment': true,
        'react-addons-test-utils': 'react-dom', // <- added this
      },
      resolve: {
        modules: [
          path.resolve(__dirname, 'node_modules'),
        ],
        modulesDirectories: [
          'node_modules',
        ],
        alias: {
          "es2015": path.resolve(__dirname, "node_modules/babel-preset-es2015"),
        }
      },
      resolveLoader: {
        root: path.resolve(__dirname, 'node_modules'),
        modules: [
          'node_modules',
        ],
        modulesDirectories: [
          'node_modules',
        ]
      },
    },
    webpackServer: {
      noInfo: true //please don't spam the console when running in karma!
    }
  });
};
