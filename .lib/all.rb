def l(msg, *lv)
  lv = lv[0] || :debug
	case lv
	  when :info
	    STDOUT.puts msg.color(:black).background(:white)
	  when :error
	    STDOUT.puts msg.color(:yellow).background(:red)
	end
end

begin
  require 'bundler'
  Bundler.require(:default)
rescue Bundler::GemNotFound => e
  l e.message, :error
  l 'Try running `bundle install`.', :error
  exit!
end
require 'fileutils'
require 'uri'

class Source
  def self.new(*opt)
    if opt[0].length > 0
      super
    end
  end
  
  def exists?
    File.exists? ROOT + @file
  end
end

class List < Source
  def initialize(*list)
    @list = list[0]
  end
end

class Style < Source
  
end

class Styles < List
  
end

class Script < Source
  def initialize(*opt)
    @opt = opt[0]
    @file = @opt[:file] if @opt[:file]
    if @opt[:as]
      @name = @opt[:as] unless @name
      @file = '/src/' + @opt[:as] + '.js' unless @file
    end
    if @opt[:url]
      @name = File.basename(URI.split(@opt[:url])[5]) unless @name
      @file = '/.tmp/' + @name unless @file
    end
    @compress = @opt[:compass] ? @opt[:compass] : ( @opt[:url] ? false : true )
  end
  
  def update
    File.delete @file if exists?
    if @opt[:url]
      l @opt[:url] + ' => ' + @file, :info
      unless system 'wget ' + @opt[:url] + ' -O ' + ROOT + @file
        l @opt[:url] + ' download faild!', :error
        exit!
      end
    end
  end
  
  def to_s
    update unless exists?
    File.open(ROOT + @file).readlines.join ''
  end
end

class Scripts < List
  def initialize(*list)
    @list = list[0]
  end
  
  def to_s
    @list.map{ |script| script.to_s }.join ';'
  end
end

def merge(*opt)
  opt[0].each do |k, v|
    l 'Merge: ' + v, :info
    k = [k] if k.class != Array
    styles = Styles.new k.select{ |o| o.class == Style }
    scripts = Scripts.new k.select{ |o| o.class == Script }
    if styles
      file = '/src/' + v + '.css'
      File.open(ROOT + file, 'w'){ |f| f.write styles.to_s }
      l v + '.css => ' + file, :info
    end
    if scripts
      file = '/src/' + v + '.js'
      File.open(ROOT + file, 'w'){ |f| f.write scripts.to_s }
      l v + '.js => ' + file, :info
    end
  end
end

def js(*opt)
  Dir.mkdir '.tmp' unless Dir.exist? '.tmp'
  return Script.new opt[0]
end

require ROOT + '/Source'
