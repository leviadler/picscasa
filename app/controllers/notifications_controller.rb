class NotificationsController < ApplicationController

  before_action :require_signed_in
  #after_action :mark_as_read

  def index
    # should these methods be moved to users model?
    @notifications = current_user.notifications.unread.order("created_at DESC")

    @old_notifications = current_user.notifications.read.limit(20).order("created_at DESC")
  end

  def show
    @notification = Notification.find(params[:id])
    @notification.update(is_unread: false)
    redirect_to @notification.url
  end

  # TODO action for marking all as read

  private
  # def mark_as_read
#     @notifications.update_all(is_unread: false)
#   end
end
