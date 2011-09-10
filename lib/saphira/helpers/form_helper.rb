module Saphira
  module Helpers
    module FormHelper
      extend ActiveSupport::Concern
    
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
    
      def saphira_image_crop(object_name, method, options = {})
        image = options[:object].send(options[:file_attribute].to_sym)
        
        value = options[:object].send(method.to_sym)
        width = height = left = top = 0
        value, width, height, left, top = value.match(/(\d+)x(\d+)\+(\d+)\+(\d+)/).to_a unless value.blank?
        
        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << javascript_tag(<<-JAVASCRIPT
          jQuery(function() {
            var mult    = #{image.height.to_f/image.thumb(options[:image_size]).height.to_f};
            var sLeft   = Math.round(#{left}/mult);
            var sTop    = Math.round(#{top}/mult);
            var sWidth  = Math.round(#{width}/mult);
            var sHeight = Math.round(#{height}/mult);
            jQuery('##{options[:id]}_image').Jcrop({
              onChange: #{options[:id]}_showCoords,
              onSelect: #{options[:id]}_showCoords,
              setSelect: [ sLeft, sTop, sLeft+sWidth, sTop+sHeight ]
            });
          });

          function #{options[:id]}_showCoords(c) {
            mult   = #{image.height.to_f/image.thumb(options[:image_size]).height.to_f};
            left   = Math.round(c.x*mult);
            p_top  = Math.round(c.y*mult);
            width  = Math.round(c.w*mult);
            height = Math.round(c.h*mult);
            if (width == 0 || height == 0) {
              jQuery('##{options[:id]}').val('');
            } else {
              jQuery('##{options[:id]}').val(width+'x'+height+'+'+left+'+'+p_top);
            }
          }
        JAVASCRIPT
        )
        output_buffer << image_tag(image.thumb(options[:image_size]).url, :id => "#{options[:id]}_image")
        output_buffer << text_field(object_name, method, options.merge({:id => options[:id], :enabled => false}))
        output_buffer
      end
    end
  end
end