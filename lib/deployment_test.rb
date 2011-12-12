unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.expand_path(File.dirname(__FILE__)), file)
    end
  end
end

require_relative 'deployment_test/postgres'
