class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  enum event_type: [:comment_on_photo, :like_on_photo, :comment_where_commented, :new_account, :new_album]


  scope :read, -> { where(is_unread: false) }
  scope :unread, -> { where(is_unread: true) }

  include Rails.application.routes.url_helpers


  def url
    case self.event_type
    when 'comment_on_photo'
      comment = self.notifiable
      photo_url(comment.photo, anchor: "comment-#{comment.id}" )
    when 'like_on_photo'
      like = self.notifiable
      photo_url(like.photo)
    when 'comment_where_commented'
      comment = self.notifiable
      photo_url(comment.photo, anchor: "comment-#{comment.id}" )
    when 'new_account'
      new_album_url
    when 'new_album'
      album = self.notifiable
      new_album_photo_url(album)
    end
  end

  def text
    case self.event_type
    when 'comment_on_photo'
      comment = self.notifiable
      comment_user = comment.user

      "#{comment_user.name} commented on your photo"
    when 'like_on_photo'
      like = self.notifiable
      like_user = like.user

      "#{like_user.name} liked your your photo"
    when 'comment_where_commented'
      comment = self.notifiable
      comment_user = comment.user

      "#{comment_user.name} commented on a photo that you commented on"
    when 'new_account'
      "Welcome #{self.user.name}! Click here to start making some albums!"
    when 'new_album'
      album = self.notifiable
      "You created '#{album.title}'. Click here to upload photos."
    end
  end

  def default_url_options
    options = {}
    options[:host] = Rails.env.production? ? "picscasa.herokuapp.com/" : "localhost:3000"
    options
  end
end
