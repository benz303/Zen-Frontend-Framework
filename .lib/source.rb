$all = {}

class Source
  attr_accessor :opt, :name, :source, :type
  
  def self.new(*opt)
    if opt[0].length > 0
      super
    end
  end
  
  def initialize(*opt)
    @opt = opt[0]
    if @opt[:url]
      @source = { :url => @opt[:url] }
      realname = /\/([^\/]+)\.(css|sass|scss|js|coffee)$/.match @opt[:url]
      @name = realname[1]
      @type = realname[2]
    elsif @opt[:git]
      @source = { :git => @opt[:git] }
      @name = @opt[:git][/\/([^\/]+)\.git/]
    elsif @opt[:loc]
      @source = { :loc => @opt[:loc] }
    end
    if @opt[:as]
      @name = @opt[:as]
      $all[@name.to_sym] = self
    end
  end
  
  def realname
    return [@name, @type].compact.join '.'
  end
  
  def realpath
    return File.join TMP, realname
  end
  
  def exists?
    File.exists? realpath
  end
  
  def update
    File.delete @file if exists?
    method = @source.keys[0]
    from = @source.values[0]
    to = realpath
    l from + ' => ' + to, :info
    case method
      when :url
        cmd = 'wget ' + from + ' -O ' + to
      when :git
        cmd = 'git clone ' + from + ' ' + to
      when :loc
        cmd = 'cp ' + from + ' ' + to
    end
    unless system cmd
      l from + ' update faild!', :error
      exit!
    end
  end
end

class List
  def add arr
    @list = @list + arr
  end
  
  def initialize(*list)
    @list = list[0]
  end
end
