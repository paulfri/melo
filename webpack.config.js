const { resolve } = require('path')
const webpack = require('webpack')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  entry: [
    './js/app.js',
    './css/app.css'
  ],
  output: {
    filename: 'js/app.js',
    path: resolve(__dirname, 'priv', 'static')
  },
  context: resolve(__dirname, 'web', 'static'),
  devtool: 'inline-source-map',
  module: {
    rules: [
      {
        test: /\.js$/,
        use: [
          'babel-loader',
        ],
        exclude: /node_modules/
      },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract({
          fallbackLoader: 'style-loader',
          loader: 'css-loader'
        })
      }
    ]
  },
  plugins: [
    new webpack.NamedModulesPlugin(),
    new ExtractTextPlugin('css/app.css'),
    new CopyWebpackPlugin([{ from: "./assets" }]),
    new webpack.ProvidePlugin({
      fetch: 'imports-loader?this=>global!exports-loader?global.fetch!whatwg-fetch'
    })
  ]
}
