class String
  def partition_all(reg)
    r = self.partition(reg)
    if reg =~ r[2]
      r[2] = self.partition_all[reg]
    end
    return r
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
    a=true if file != @file
    p File.open(file).readlines.join('') if a
    r = File.open(file).readlines.join('').partition(reg)
    p r
    f1 = File.join File.dirname(file), reg.match(r[1])[1]
    if File.exists? f1
      r[1] = File.open(f1).readlines.join('')
    else
      l f, 404
    end
    if reg =~ r[2]
      
    end
    return r.join('')
  end
end

class Styles < List
  def to_s
    @list.map{ |s| s.to_s }.join ''
  end
end

def css(*opt)
  return Style.new opt[0]
end
