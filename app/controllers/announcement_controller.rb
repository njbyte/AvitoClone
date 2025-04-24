class AnnouncementController < ApplicationController
    before_action :set_announcement, only: [:edit, :update, :destroy]
    before_action :authenticated?, except: [:show, :index]
    allow_unauthenticated_access only: [:index, :show] 
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    
    def index
      if params[:category].present?
        @announcements = Announcement.where(category: params[:category])
      
      else
        @announcements = Announcement.all
      end
    end
  
    def new
      @announcement = Announcement.new
    end

    def myannounce
      @announcements = Announcement.where(user_id: session[:user_id])
    end
    def show
      @announcement = Announcement.find(params[:id])
      @announcement.increment!(:views_count)
    rescue ActiveRecord::RecordNotFound
      redirect_to announcement_index_path, alert: "Announcement not found"
    end


    def create
      @announcement = current_user.announcements.build(announcement_params)
  
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

private 
    def current_user
      # This depends on how you store user sessions.
      # Example if using session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    def require_login
      unless current_user
        redirect_to root_path, alert: "You must be logged in to access this page."
      end
    end
    def authorize_user!
      @announcement = Announcement.find(params[:id])
      unless @announcement.user_id == current_user&.id
        redirect_to announcement_index_path, alert: "You're not authorized to perform this action."
      end
    end
  end
  