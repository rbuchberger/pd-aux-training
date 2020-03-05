module NavigationHelper
  def dynamic_navbar_links
    if user_signed_in?
      render 'application/navigation/logged_in_links'
    else
      render 'application/navigation/logged_out_links'
    end
  end

  def admin_links
    render 'application/navigation/admin_links' if current_user.trainer?
  end
end
