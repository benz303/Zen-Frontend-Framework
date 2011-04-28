class String
  def partition_all(reg)
    r = self.partition(reg)
    if reg =~ r[2]
      r[2] = r[2].partition_all(reg)
    end
    return r.flatten
  end
end

class Style < Source
  def to_s
    update unless exists?
    return import_css(@file)
  end
  
  private
  
  def import_css(file)
    reg = /@import[^"]+"([^"]+)"/
    return File.open(file).readlines.join('').partition_all(reg).map { |f|
      if reg =~ f
        path = File.join File.dirname(file), reg.match(f)[1]
        if File.exists? path
          f = import_css(path)
        else
          l f, 404
        end
      end
      f
    }.join "\n"
  end
end

class Styles < List
  def to_s
    @list.map{ |s| s.to_s }.join "\n"
  end
end

def css(*opt)
  return Style.new opt[0]
end
