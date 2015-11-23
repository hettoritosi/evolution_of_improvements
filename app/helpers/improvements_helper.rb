module ImprovementsHelper
  def set_status_color(status_name)
    if status_name == "Finalizado"
      return "success"
    elsif
      status_name == "Inicializado"
      return "danger"
    else
      return "info"
    end
  end

    def gravatar_for(user)
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end

  end
