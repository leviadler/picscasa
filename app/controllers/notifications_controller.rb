class NotificationsController < ApplicationController
  
  before_action :require_signed_in
  after_action :mark_as_read
  
  def index
    @notifications = current_user.notifications.where(is_unread: true)
    
    @old_notifications = current_user.notifications.where(is_unread: false).limit(20)
  end
  
  def update
    
  end
  
  private
  def mark_as_read
    @notifications.update_all(is_unread: false)
  end
end