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
end
