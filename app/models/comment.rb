class Comment < ActiveRecord::Base
  validates :body, :user_id, :photo_id, presence: true

  belongs_to :user
  belongs_to :photo

  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create :create_notifications

  private

  # maybe don't add if user == current_user
  def create_notifications
    unless self.photo.owner == self.user
      Notification.create(
        notifiable: self,
        user: self.photo.owner,
        event_type: 'comment_on_photo'
      )
    end

    # for now only notifying for public b/c can't pass on auth token
    # for unlisted albums to link to the photo
    if self.photo.album.public_album?
      # filter so that don't get multiple notification if own photo
      # or also commented on that photo
      users_to_notify = self.photo.comments
                            .map { |comment| comment.user }
                            .reject { |user| user == self.user || user == self.photo.owner }
                            .uniq

      users_to_notify.each do |user|
        Notification.create(
          notifiable: self,
          user: user,
          event_type: "comment_where_commented"
        )
      end
    end
  end
end
