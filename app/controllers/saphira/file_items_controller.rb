module Saphira
  class FileItemsController < ApplicationController
    # GET /file_items
    # GET /file_items.json
    def index
      @file_item = FileItem.new(:name => 'ROOT')
      @file_items = FileItem.where(:parent_id => nil).all
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @file_items }
      end
    end

    # GET /file_items/1
    # GET /file_items/1.json
    def show
      @file_item = FileItem.find_by_path(params[:id])

      respond_to do |format|
        format.html do
          case @file_item.item_type
          when Saphira::FileItem::TYPE_FOLDER
            @file_items = @file_item.children
            render :action => 'index'
          else
            render
          end
        end
        format.json { render :json => @file_item }
      end
    end

    # GET /file_items/new
    # GET /file_items/new.json
    def new
      @file_item = FileItem.new
      @file_item.item_type = params[:type]
      @file_item.parent_id = params[:parent_id]

      respond_to do |format|
        format.html { render :action => "new_#{@file_item.item_type}" }
        format.json { render :json => @file_item }
      end
    end

    # GET /file_items/1/edit
    def edit
      @file_item = FileItem.find_by_path(params[:id])

      respond_to do |format|
        format.html { render :action => "edit_#{@file_item.item_type}" }
        format.json { render :json => @file_item }
      end
    end

    # POST /file_items
    # POST /file_items.json
    def create
      @file_item = FileItem.new(params[:file_item])

      respond_to do |format|
        if @file_item.save
          format.html { redirect_to @file_item, :notice => 'File item was successfully created.' }
          format.json { render :json => @file_item, :status => :created, :location => @file_item }
        else
          format.html { render :action => "new_#{@file_item.item_type}" }
          format.json { render :json => @file_item.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /file_items/1
    # PUT /file_items/1.json
    def update
      @file_item = FileItem.find_by_path(params[:id])

      respond_to do |format|
        if @file_item.update_attributes(params[:file_item])
          format.html { redirect_to @file_item, :notice => 'File item was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render :action => "edit_#{@file_item.item_type}" }
          format.json { render :json => @file_item.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /file_items/1
    # DELETE /file_items/1.json
    def destroy
      @file_item = FileItem.find_by_path(params[:id])
      @file_item.destroy

      respond_to do |format|
        format.html { redirect_to file_items_url }
        format.json { head :ok }
      end
    end
  end
end
