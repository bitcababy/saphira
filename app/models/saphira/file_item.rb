module Saphira
  class FileItem < ActiveRecord::Base
    extend FriendlyId
    
    TYPE_FILE = 'file'
    TYPE_FOLDER = 'folder'
    
    serialize :dynamic_attributes
    
    validates_presence_of :name
    validates_uniqueness_of :name, :scope => :parent_id
    before_validation do
      self.name = self.file_name if self.name.blank?
    end
    
    acts_as_nested_set
    friendly_id :name, :use => :scoped, :scope => :parent_id
    acts_as_taggable
    file_accessor :file do
        after_assign do |img|
          if (img.image?)
            # set the mime type
            case img.mime_type
            when 'image/jpeg'
              exifr = EXIFR::JPEG.new(img.path.to_s)
            when 'image/tiff'
              exifr = EXIFR::TIFF.new(img.path.to_s)
            end
            
            # set the size, this can be refactured using dragonfly if the with method
            # of the analyzer is fixed (see https://github.com/markevans/dragonfly/issues/122)
            mm_image = MiniMagick::Image.open(img.path)
            self.field_width = mm_image[:width]
            self.field_height = mm_image[:height]
            
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

    def self.cs(scope)
      where(:record_scope => scope)
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
    
    def image_variant(id)
      raise "the given file is no image" unless file.image?
      variant = ImageVariant.find(id)
      raise "no variant with id #{id} found" unless variant
      file.manipulate(self.pre_manipulation(id) + ' ' + variant.manipulation)
    end
    
    def pre_manipulation(id)
      self.attr_get("pre_manipulation_#{id}") || ''
    end
    
    def method_missing(method_name, *args, &block)  
      case method_name
      when /^field_([a-zA-Z0-9_]+)$/
        attr_get($1)
      when /^field_([a-zA-Z0-9_]+)=$/
        attr_set($1, args[0])
      else
        super
      end
    end

    # Overrides update_attributes to take dynamic attributes into account
    def update_attributes(attributes)  
      attributes.each do |key, value|
        if key.match(/^field_([a-zA-Z0-9_]+)$/)
          attr_set($1, attributes.delete(key))
        end
      end
      super(attributes)
    end
    
    def to_param
      self.path.empty? ? super : self.path
    end
  end
end
