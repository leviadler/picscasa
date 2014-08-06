class Api::NotificationsController < ApplicationController

  before_action :require_signed_in
  #after_action :mark_as_read

  def index
    @notifications = current_user.notifications.unread.order("created_at DESC").limit(5)
    render "index"

    # @old_notifications = current_user.notifications.read.limit(20).order("created_at DESC")
  end

  def show
    @notification = Notification.find(params[:id])
    @notification.update(is_unread: false)
    render "show"
  end

  def update
    @notification = Notification.find(params[:id])
    @notification.update(is_unread: false)
    render "show"
  end

  # TODO action for marking all as read

  private
  # def mark_as_read
  #   @notifications.update_all(is_unread: false)
  # end
end
