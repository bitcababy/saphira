module Saphira
  class ImageVariantSettingsController < ApplicationController
    # GET /file_items/1/image_variant_settings/1
    # GET /file_items/1/image_variant_settings/1.json
    def show
      @file_item = FileItem.find_by_path(params[:file_item_id])
      @image_variant = ImageVariant.find(params[:id])

      respond_to do |format|
        format.html { }
        format.json { render :json => @file_item }
      end
    end

    # GET /file_items/1/image_variant_settings/1/edit
    def edit
      @file_item = FileItem.find_by_path(params[:file_item_id])

      respond_to do |format|
        format.html { }
        format.json { render :json => @file_item }
      end
    end

    # PUT /file_items/1/image_variant_settings/1
    # PUT /file_items/1/image_variant_settings/1.json
    def update
      @file_item = FileItem.find_by_path(params[:file_item_id])

      respond_to do |format|
        if @file_item.update_attributes(params[:file_item])
          format.html { redirect_to @file_item, :notice => 'File item was successfully updated.' }
          format.json { head :ok }
        else
          format.html { }
          format.json { render :json => @file_item.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
end
