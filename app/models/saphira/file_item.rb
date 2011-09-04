module Saphira
  class FileItem < ActiveRecord::Base
    extend FriendlyId
    
    TYPE_FILE = 'file'
    TYPE_FOLDER = 'folder'
    
    serialize :dynamic_attributes
    
    validates_presence_of :name
    validates_uniqueness_of :name, :scope => :parent_id
    
    acts_as_nested_set
    friendly_id :name, :use => :scoped, :scope => :parent_id
    acts_as_taggable
    file_accessor :file do
        after_assign do |img|
          if (img.image?)
            case img.mime_type
            when 'image/jpeg'
              exifr = EXIFR::JPEG.new(img.path.to_s)
            when 'image/tiff'
              exifr = EXIFR::TIFF.new(img.path.to_s)
            end
            # http://www.dcresource.com/reviews/exif_key.html
            if exifr
              self.attr_set :field_image_capture_date, exifr.date_time_original
              self.attr_set :field_image_exposure_time, exifr.exposure_time
              self.attr_set :field_image_f_number, exifr.f_number
              self.attr_set :field_image_capture_date, exifr.date_time_original
              self.attr_set :field_image_make, exifr.make
              self.attr_set :field_image_model, exifr.model
              self.attr_set :field_image_orientation, exifr.orientation.to_i
              
              # Some cameras are having a orientation sensor. The output is saved in the
              # EXIF orientation attribute. If the orientation is set, try to rotate the
              # image like specified (see: http://www.impulseadventure.com/photo/exif-orientation.html)
              if exifr.orientation
                case exifr.orientation.to_i
                when 8
                  img.process!(:rotate, 270)
                  self.attr_set :field_image_orientation_transformed, true
                when 3
                  img.process!(:rotate, 180)
                  self.attr_set :field_image_orientation_transformed, true
                when 6
                  img.process!(:rotate, 90)
                  self.attr_set :field_image_orientation_transformed, true
                end
              end
            end
          end
        end
    end
    
    belongs_to :user
    
    # generate the path of this item, to find it easier
    before_save do
      parent = self.parent
      if parent
        self.path = parent.path+'/'+self.slug
      else
        self.path = self.slug
      end
    end

    def attr_set(name, value)
      self.dynamic_attributes ||= {}
      self.dynamic_attributes[name.to_sym] = value
      self.dynamic_attributes = self.dynamic_attributes.delete_if { |k, v| v.blank? }
    end

    def attr_get(name)
      self.dynamic_attributes ||= {}
      self.dynamic_attributes[name.to_sym]
    end
    
    def to_param
      self.path.empty? ? super : self.path
    end
  end
end
