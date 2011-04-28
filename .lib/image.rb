class Image < Source
  def to_s
    update unless exists?
  end
end

class Images < List
  def merge name
    to = File.join SRC, realtype, name
    l '  => ' + to, :info
    Dir.mkdir to unless File.exists? to
    @list.each do |img|
      FileUtils.cp img.file, File.join(SRC, realtype, name, File.basename(img.file))
    end
  end
end

def img(*opt)
  return Image.new opt[0]
end
