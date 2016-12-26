const config = require('./webpack.config')
const webpack = require('webpack')

const prodConfig = {
  devtool: false,
  plugins: config.plugins.concat(
    new webpack.DefinePlugin({
      'process.env':{
        'NODE_ENV': JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin()
  )
}

module.exports = Object.assign({}, config, prodConfig)
