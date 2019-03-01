const { environment } = require('@rails/webpacker')

module.exports = environment;

environment.loaders.append('import-glob', {
  test: /\.scss$/,
  use: 'import-glob-loader'
});
