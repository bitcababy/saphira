module Saphira
  module Helpers
    module FormBuilder
      extend ActiveSupport::Concern
    
      def saphira_image_crop(method, *args)
        options = {
          :image_size         => 'x300',
          :id                 => "#{@object_name}_#{method}",
          :object             => object,
          :file_attribute     => :file,
          :force_aspect_ratio => false,
          :aspect_ratio       => 0
        }.merge(args.extract_options!)
        @template.send("saphira_image_crop", @object_name, method, options)
      end
    end
  end
end