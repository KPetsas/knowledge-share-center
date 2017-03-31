module ApplicationHelper

  def avatar_for(user, options = { size: 60 })
    size = options[:size]
    avatar_url = "http://img1.jurko.net/avatar_3854.gif"
    image_tag(avatar_url, size: size, alt: user.expertname, class: "img-circle")
  end

end
