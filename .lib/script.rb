class Script < Source 
  def to_s
    update unless exists?
    File.open(realpath).readlines.join ''
  end
end

class Scripts < List
  def to_s
    @list.map{ |s| s.to_s }.join ';'
  end
end

def js(*opt)
  return Script.new opt[0]
end
