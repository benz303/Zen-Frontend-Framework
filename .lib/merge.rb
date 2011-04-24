def merge(*opt)
  opt[0].each do |list, name|
    l 'Merge: ' + name, :info
    list = [list] if list.class != Array
    styles, scripts, images = [], [], []
    list.each do |source|
      source = $all[source] if source.class == Symbol
      styles.push source if source.class == Style
      scripts.push source if source.class == Script
      images.push source if source.class == Image
    end
    if styles.length > 0
      file = File.join ROOT, 'src', name + '.css'
      File.open(file, 'w'){ |f| f.write Styles.new(styles).to_s }
      l name + '.css => ' + file, :info
    end
    if scripts.length > 0
      file = File.join ROOT, 'src', name + '.js'
      File.open(file, 'w'){ |f| f.write Scripts.new(scripts).to_s }
      l name + '.js => ' + file, :info
    end
    if images.length > 0
      file = File.join ROOT, 'src', name + '.img'
      File.open(file, 'w'){ |f| f.write Images.new(images).to_s }
      l name + '.img => ' + file, :info
    end
  end
end
