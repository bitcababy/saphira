module Saphira
  module Helpers
    module FormHelper
      extend ActiveSupport::Concern
    
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
    
      def saphira_image_crop(object_name, method, options = {})
        image = options[:object].send(options[:file_attribute].to_sym)
        
        value = options[:object].send(method.to_sym)
        mult = image.height.to_f/image.thumb(options[:image_size]).height.to_f
        width = height = left = top = 0
        value, width, height, left, top = value.match(/(\d+)x(\d+)\+(\d+)\+(\d+)/).to_a.map{|i| (i.to_f/mult).round } unless value.blank?
        
        output_buffer = ActiveSupport::SafeBuffer.new
        js_buffer     = ActiveSupport::SafeBuffer.new
        jcrop_options = []
        jcrop_options << "onChange: #{options[:id]}_showCoords"
        jcrop_options << "onSelect: #{options[:id]}_showCoords"
        jcrop_options << "setSelect: [#{left}, #{top}, #{left+width}, #{top+height} ]" unless width==0 and height==0
        jcrop_options << "aspectRatio: #{options[:aspect_ratio]}" if options[:aspect_ratio]
        js_buffer << <<-JAVASCRIPT
          jQuery(function() {
            jQuery('##{options[:id]}_image').Jcrop({#{jcrop_options.join(',')}});
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
        
        unless options[:aspect_ratio]>0 and options[:force_asprct_ratio]
          output_buffer << <<-HTML.html_safe
            <input type="checkbox" id="#{options[:id]}_aspect_ratio_toggle" checked="checked" />
            <label for="#{options[:id]}_aspect_ratio_toggle">#{t 'saphira.general.use_target_aspect_ratio', :default => 'Use target aspect ratio'}</label>
          HTML
          js_buffer << <<-JAVASCRIPT
            jQuery(function() {
              jQuery('##{options[:id]}_aspect_ratio_toggle').click(function() {
                if(this.checked) {
                  jQuery('##{options[:id]}_image').data('Jcrop').setOptions({ aspectRatio: #{options[:aspect_ratio]} });
                } else {
                  jQuery('##{options[:id]}_image').data('Jcrop').setOptions({ aspectRatio: 0 });
                }
              });
            });
          JAVASCRIPT
        end
        output_buffer << javascript_tag(js_buffer)
        output_buffer << image_tag(image.thumb(options[:image_size]).url, :id => "#{options[:id]}_image")
        output_buffer << text_field(object_name, method, options.merge({:id => options[:id], :enabled => false}))
        output_buffer
      end
    end
  end
end