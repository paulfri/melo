const config = require('./webpack.config')
const webpack = require('webpack')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')

const prodConfig = {
  devtool: false,
  plugins: [
    new webpack.DefinePlugin({
      'process.env':{
        'NODE_ENV': JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin(),
    new ExtractTextPlugin('css/app.css'),
    new CopyWebpackPlugin([{ from: "./assets" }])
  ]
}

module.exports = Object.assign(config, prodConfig)
