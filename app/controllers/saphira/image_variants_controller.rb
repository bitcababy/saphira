module Saphira
  class ImageVariantsController < ApplicationController
    # GET /image_variants
    # GET /image_variants.json
    def index
      @image_variants = ImageVariant.cs(self.current_scope).all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @image_variants }
      end
    end
  
    # GET /image_variants/1
    # GET /image_variants/1.json
    def show
      @image_variant = ImageVariant.cs(self.current_scope).find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @image_variant }
      end
    end
  
    # GET /image_variants/new
    # GET /image_variants/new.json
    def new
      @image_variant = ImageVariant.cs(self.current_scope).new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @image_variant }
      end
    end
  
    # GET /image_variants/1/edit
    def edit
      @image_variant = ImageVariant.cs(self.current_scope).find(params[:id])
    end
  
    # POST /image_variants
    # POST /image_variants.json
    def create
      @image_variant = ImageVariant.cs(self.current_scope).new(params[:image_variant])
  
      respond_to do |format|
        if @image_variant.save
          format.html { redirect_to @image_variant, notice: 'Image variant was successfully created.' }
          format.json { render json: @image_variant, status: :created, location: @image_variant }
        else
          format.html { render action: "new" }
          format.json { render json: @image_variant.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /image_variants/1
    # PUT /image_variants/1.json
    def update
      @image_variant = ImageVariant.cs(self.current_scope).find(params[:id])
  
      respond_to do |format|
        if @image_variant.update_attributes(params[:image_variant])
          format.html { redirect_to @image_variant, notice: 'Image variant was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @image_variant.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /image_variants/1
    # DELETE /image_variants/1.json
    def destroy
      @image_variant = ImageVariant.cs(self.current_scope).find(params[:id])
      @image_variant.destroy
  
      respond_to do |format|
        format.html { redirect_to image_variants_url }
        format.json { head :ok }
      end
    end
  end
end
