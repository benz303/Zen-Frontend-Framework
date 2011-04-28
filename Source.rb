merge [
  js(:url => 'https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js', :as => 'jquery'),
  js(:url => 'http://documentcloud.github.com/underscore/underscore-min.js', :as => 'underscore')
] => 'core'

merge [:jquery, :underscore] => 'core2'

merge framework(:git => 'https://github.com/jquery/jquery-ui.git',
  :js => {
    :path => 'demos/index.html',
    :find => lambda { |f| f.scan(/<script.*src="([^"]+)/ix).map{ |file| file[0] } },
    :compress => true
  },
  :css => {
    :file => 'themes/base/jquery.ui.all.css'
  },
  :img => {
    :dir => 'themes/base/images/*.png'
  }) => 'jqueryui'
