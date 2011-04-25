class Image < Source
  def to_s
    update unless exists?
  end
end

class Images < List
  def to_s
    @list.map{ |s| s.to_s }
  end
end

def img(*opt)
  return Image.new opt[0]
end
