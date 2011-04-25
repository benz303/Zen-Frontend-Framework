class Framework < Source
  attr_accessor :css, :js, :img
  
  def init
    all = {
      :css => [],
      :js => [],
      :img => []
    }
    [:css, :js, :img].each do |c|
      if @opt[c]
        opt = @opt[c]
        if opt[:file]
          opt[:file] = File.join(@file, opt[:file])
          if File.exists? opt[:file]
            all[c].push Name[c][0].new opt
          else
            l opt[:file], 404
          end
        elsif opt[:dir]
          dir = File.join(@file, opt[:dir])
          if Dir[dir].length > 0
            Dir[dir].each do |f|
              opt.delete :dir
              opt[:file] = f
              all[c].push Name[c][0].new opt
            end
          else
            l dir, 404
          end
        elsif opt[:path] && opt[:find]
          path = File.join(@file, opt[:path])
          if File.exists? path
            list = opt[:find].call(File.open(path, 'r').readlines.join(''))
            list.each do |f|
              f = File.join(File.dirname(path), f)
              if File.exists? f
                opt.delete :path
                opt.delete :find
                opt[:file] = f
                all[c].push opt
              else
                l f, 404
              end
            end
          else
            l path, 404
          end
        else
          l opt, 404
        end
      end
    end
    @css = all[:css]
    @js = all[:js]
    @img = all[:img]
  end
  
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
