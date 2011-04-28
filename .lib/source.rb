$all = {}
class Source
  attr_accessor :opt, :name, :source, :type, :file
  
  def self.new(*opt)
    if opt[0].length > 0
      super
    end
  end
  
  def initialize(*opt)
    @opt = opt[0]
    if @opt[:file]
      if File.exists? @opt[:file]
        @file = @opt[:file]
      elsif File.exists? File.join(TMP, @opt[:file])
        @file = File.join(TMP, @opt[:file])
      else
        l @opt[:file], 404
      end
      @source = { :loc => @file }
    elsif @opt[:url]
      @source = { :url => @opt[:url] }
      unless @file
        @file = File.join TMP, /\/([^\/]+)\.(css|sass|scss|js|coffee|jpg|jpeg|gif|png|git)$/.match(@opt[:url])[0]
      end
    elsif @opt[:git]
      @source = { :git => @opt[:git] }
      @file = File.join TMP, @opt[:git][/\/([^\/]+)\.git/] unless @file
    else
      l opt, 404
    end
    @type = File.extname(@file)
    if @opt[:as]
      @name = @opt[:as]
      $all[@name.to_sym] = self
    end
    
    update unless exists?
    init if defined? init
  end
  
  def realpath
    return @file
  end
  
  def exists?
    File.exists? @file
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
  
  def realtype
    case @type
      when 'css', 'scss', 'sass'
        return 'css'
      when 'js', 'coffee'
        return 'js'
      when 'jpg', 'jpeg', 'gif', 'png'
        return 'img'
      else
        return 'unknown'
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
  
  def realtype
    case self.class.name
      when 'Styles'
        return 'css'
      when 'Scripts'
        return 'js'
      when 'Images'
        return 'img'
      else
        return 'unknown'
    end
  end
  
  def merge name
    to = File.join SRC, realtype, name + '.' + realtype
    l '  => ' + to, :info
    File.open(to, 'w'){ |f| f.write to_s }
  end
end
