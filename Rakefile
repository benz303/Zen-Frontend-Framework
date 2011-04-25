ROOT = File.dirname(__FILE__)
SRC = File.join ROOT, 'src'
TMP = File.join ROOT, '.tmp'
require 'fileutils'

begin
  require 'bundler'
  Bundler.require(:default)
rescue Bundler::GemNotFound => e
  l e.message, :error
  l 'Try running `bundle install`.', :error
  exit!
end

def l(msg, *lv)
  lv = (lv[0] || :debug).to_s
  if lv == '404'
    lv = 'error'
    msg = msg.to_s + ' is not found!'
  end
	case lv
	  when 'info'
	    STDOUT.puts msg.color(:black).background(:white)
	  when 'error'
	    STDOUT.puts msg.color(:yellow).background(:red)
	end
end

[SRC, TMP].each{ |f| Dir.mkdir f unless Dir.exist? f }

desc 'Merge all css & js source'
task :merge do
  ['source', 'script', 'style', 'image', 'framework', 'merge'].each { |f| require File.join( ROOT, '.lib', f) }
  Name = {
    :css => [Style, Styles],
    :js => [Script, Scripts],
    :img => [Image, Images]
  }
  require File.join( ROOT, 'Source')
end

desc 'Clear all src & tmp file'
task :clear do
  [SRC, TMP].each{ |f| FileUtils.rm_r f }
end
