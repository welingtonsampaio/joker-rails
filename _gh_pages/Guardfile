# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard "jekyll-plus" do
  watch /.*/
  ignore /^_site|\.idea/
end

# Read more about stitch-plus configuration at https://github.com/imathis/guard-stitch-plus
#
stitch_config = {
  dependencies: %w(assets/js/jquery.js dist/js/bootstrap.js js/widgets.js assets/js/holder.js assets/js/application.js),
  paths: %w(javascripts/modules),
  output: 'assets/js/site.js',
  uglify: true
}

guard 'stitch-plus', stitch_config do
  watch /assets\/js\/.*\.js/
end

