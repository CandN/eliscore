var path = require('path');
var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: ["./css/app.css", "./js/app.js"],
  output: {
    path: "../priv/static/",
    filename: "js/app.js"
  },
  module: {
    loaders: [{
      test: /\.jsx?$/,
      exclude: /(node_modules|deps)/,
      loader: "babel-loader",
      query: {
        presets: ["es2015", "react", "stage-0", "stage-2"]
      }
    }, {
      test: /\.scss$/,
      loader: ExtractTextPlugin.extract("style", "css!sass")
    }, {
      test: /\.(png|jpg|jpeg|gif|svg|woff|woff2)$/,
      loader: 'url-loader?limit=10000',
    }, {
      test: /\.(eot|ttf)$/,
      loader: 'file-loader',
    }]
  },
  plugins: [
    new ExtractTextPlugin("css/app.css")
  ],
  resolve: {
    extensions: ['', '.js', '.jsx'],
    modulesDirectories: ["node_modules", __dirname + "../priv/static/js"],
    alias: {
      "phoenix": path.resolve(__dirname, "../deps/phoenix/priv/static/phoenix.js"),
      "phoenix_html": path.resolve(__dirname, "../deps/phoenix_html/priv/static/phoenix_html.js")
    }
  }
};
