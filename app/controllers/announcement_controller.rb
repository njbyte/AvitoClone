class AnnouncementController < ApplicationController
    before_action :set_announcement, only: [:edit, :update, :destroy]
  
    def index
      @announcements = Announcement.all
    end
  
    def new
      @announcement = Announcement.new
    end


    def show
      @announcement = Announcement.find(params[:id])
      @announcement.increment!(:views_count)
    rescue ActiveRecord::RecordNotFound
      redirect_to announcement_index_path, alert: "Announcement not found"
    end


    def create
      @announcement = Announcement.new(announcement_params)
      if @announcement.save
        redirect_to announcement_index_path, notice: "Announcement created successfully!"
      else
        render :new
      end
    end
  
    def edit
      @announcement = Announcement.find(params[:id])
    end
  
    def update
          @announcement = Announcement.find(params[:id])
      if @announcement.update(announcement_params)
        redirect_to @announcement, notice: "Announcement updated successfully."
      else
        render :edit
      end
    end
  
    def destroy
      @announcement = Announcement.find(params[:id])
      @announcement.destroy
      redirect_to announcement_index_path, notice: "Announcement deleted successfully!"
    end
  
    private
  
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end
  
    def announcement_params
      params.require(:announcement).permit(
        :title, :description, :price, :currency, :condition, 
        :category, :subcategory, :city, :region, :seller_name,
        :phone_number, :email, :video_url, :expires_at,
        :status, :is_featured, :is_verified,
        images: []  # Permit multiple image uploads
      )
    end
  end
  