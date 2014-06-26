class ShareMailer < ActionMailer::Base
  default from: "notifications@picscasa.com"
  
  def share_email(album, message, email_list)
    @album = album
    if album.public_album?
      @url = album_url(album)
    elsif album.unlisted_album?
      @url = album_url(album, auth_token: album.auth_token)
    end
    @message = message
    mail(to: "#{album.owner.name} <#{album.owner.email}>", bcc: email_list,
        subject: "#{album.owner.name} shared an album with you.")
  end
end
