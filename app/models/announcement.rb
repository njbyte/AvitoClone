class Announcement < ApplicationRecord

    
    # Active Storage attachments (for image uploads)
    has_many_attached :images
    belongs_to :user
    # Validations
    validates :title, :description, :price, :category, :city, :seller_name, :phone_number, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
    validates :phone_number, format: { with: /\A\d{10,15}\z/, message: "must be a valid phone number" }
  
    # Callbacks
    before_create :set_defaults
  
    # Custom methods
    def thumbnail(image)
      image.variant(resize: '300x300') if image.variable?
    end
  
    private
  
    def set_defaults
      self.published_at ||= Time.current
      self.views_count ||= 0
      self.status ||= 'active'
      self.is_featured ||= false
      self.is_verified ||= false
    end
  end