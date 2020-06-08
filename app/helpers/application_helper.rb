module ApplicationHelper

  def authenticate_user!(opts={})
    opts[:scope] = :user
    warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
  end

  def user_signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= warden.authenticate(:scope => :user)
  end

  def user_session
    current_user && warden.session(:user)
  end

  def header_link_item(name, path)
    class_name = 'nav-item'
    class_name << ' active' if current_page?(path)

    content_tag :li, class: class_name do
      link_to name, path, class: 'nav-link'
    end
  end



end
