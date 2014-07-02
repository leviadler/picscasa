class ShareMailer < ActionMailer::Base
  default from: "notifications@picscasa.com"
  
  def rails_share_email(album, message, email_list)
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
  
  
  def share_email(album, message, email_list, url)
    @album = album
    @url = url
    @message = message
    mail(to: "#{album.owner.name} <#{album.owner.email}>", bcc: email_list,
        subject: "#{album.owner.name} shared an album with you.")
  end
end
