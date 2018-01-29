# --- completion
require 'irb/completion'
require 'wirble'

Wirble.init
Wirble.colorize

module Kernel
  def r(arg)
    if RUBY_VERSION < "1.9"
      puts `refe #{arg}`
    else
      puts `refe1.9 #{arg}`
    end
  end
  private :r
end

class Module
  def r(meth = nil)
    if meth
      if instance_methods(false).include? meth.to_s
        refe = "refe"
        if RUBY_VERSION >= "1.9"
          refe += "1.9"
        end
        puts `#{refe} #{self}##{meth}`
      else
        super
      end
    else
      puts `refe #{self}`
    end
  end
end


def ls
  print `ls -CF`
end

unless defined?(MACRUBY_VERSION)
  require 'rubygems'
  require 'wirb' 
  Wirb.start
end
