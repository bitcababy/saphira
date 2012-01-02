module Saphira
  class ImageVariant < ActiveRecord::Base
    def self.cs(scope)
      where(:record_scope => scope)
    end
  end
end
