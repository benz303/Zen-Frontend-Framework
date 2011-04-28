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
      if source.class == Framework
        source.css.each{ |s| styles.push s } if source.css.length > 0
        source.js.each{ |s| scripts.push s } if source.js.length > 0
        source.img.each{ |s| images.push s } if source.img.length > 0
      end
    end
    if styles.length > 0
      Styles.new(styles).merge name
    end
    if scripts.length > 0
      Scripts.new(scripts).merge name
    end
    if images.length > 0
      Images.new(images).merge name
    end
  end
end
