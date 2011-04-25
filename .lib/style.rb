class Style < Source
  def to_s
    update unless exists?
    File.open(realpath).readlines.join ''
  end
end

class Styles < List
  def to_s
    @list.map{ |s| s.to_s }.join ';'
  end
end

def css(*opt)
  return Style.new opt[0]
end
