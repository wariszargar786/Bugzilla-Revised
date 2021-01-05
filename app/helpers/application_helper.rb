module ApplicationHelper
  def login_register_link
    if current_user
      content_tag(:li, (link_to "Logout", destroy_user_session_path, method: :delete, class: "nav-link"), class: "nav-item")
    else
      content_tag(:li, (link_to "Login", new_user_session_path, class: "nav-link"), class: "nav-item")+
      content_tag(:li, (link_to "Register", new_user_registration_path, class: "nav-link"), class: "nav-item")
    end
  end
  def is_active(action)
    params[:action] == action ? "active" : ''
  end
end
