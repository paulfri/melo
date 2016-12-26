const { resolve } = require('path')
const webpack = require('webpack')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  entry: [
    './js/app.js',
    './css/app.scss'
  ],
  output: {
    filename: 'js/app.js',
    path: resolve(__dirname, 'priv', 'static')
  },
  context: resolve(__dirname, 'web', 'static'),
  devtool: 'inline-source-map',
  resolve: {
    modules: [
      resolve(__dirname, 'web', 'static', 'js'),
      resolve(__dirname, 'node_modules')
    ]
  },
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
        test: /\.scss$/,
        loader: [
          ExtractTextPlugin.extract({
            fallbackLoader: 'style-loader',
            loader: 'css-loader'
          }),
          'css-loader',
          'sass-loader'
        ]
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
