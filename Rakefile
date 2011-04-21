ROOT = File.dirname(__FILE__)

[ROOT + '/src', ROOT + '/.tmp'].each{ |f| Dir.mkdir f unless Dir.exist? f }

desc 'Merge all css & js source'
task :merge do
  require ROOT + '/.lib/all'
end

desc 'Clear all src & tmp file'
task :clear do
  [ROOT + '/src', ROOT + '/.tmp'].each{ |f| FileUtils.rm_r f }
end
