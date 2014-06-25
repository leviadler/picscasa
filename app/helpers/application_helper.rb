module ApplicationHelper

  def auth_token_input
    <<-HTML.html_safe
      <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">
    HTML
  end

  def gravatar_for(user, size = 50)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
    <<-HTML.html_safe
      <img src="#{gravatar_url}" class="gravatar" alt="#{user.name}">
    HTML
  end
  
  #change with own icons
  def status_icon_for(album)
    if album.private_album?
      icon_url = "http://www.clker.com/cliparts/B/1/y/Z/B/s/padlock-icon-hi.png"
    elsif album.unlisted_album?
      icon_url = "http://www.clker.com/cliparts/B/1/y/Z/B/s/padlock-icon-hi.png"
    else
      icon_url = "http://www.clker.com/cliparts/g/n/l/b/h/Q/world-globe-b-w-md.png"
    end
    <<-HTML.html_safe
      <img src="#{icon_url}" class="album-status-icon" width="10px">
    HTML
  end
end
