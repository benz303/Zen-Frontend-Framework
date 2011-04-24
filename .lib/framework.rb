class Framework < Source
  def styles
  
  end
  
  def scripts
  
  end
  
  def images
  
  end
end

def framework *opt
  p opt[0]
  return Framework.new opt[0]
end
