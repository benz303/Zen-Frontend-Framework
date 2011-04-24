merge [
  js(:url => 'https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js', :as => 'jquery'),
  js(:url => 'http://documentcloud.github.com/underscore/underscore-min.js', :as => 'underscore')
] => 'core'

merge [:jquery, :underscore] => 'core2'

merge framework(:git => 'https://github.com/jquery/jquery-ui.git',
  :js => {
    :file => 'demos/index.html',
    :find => lambda { |f| f.readlines.join('').match(/<script.*src="([^"]+)/).map{ |file| file.gsub(/^\.\.\//, '') } }
  },
  :css => {
    :file => 'themes/base/jquery.ui.all.css'
  },
  :img => {
    :file => 'themes/base/images/*.png'
  }) => 'jqueryui'
