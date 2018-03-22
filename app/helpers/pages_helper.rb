module PagesHelper

  def dynamic_homepage_content
    if user_signed_in?
      render 'logged_in'
    else
      render 'logged_out'
    end
  end

  def last_workday
    render 'last_workday'
  end

  def pending_users
    if policy(User).index? && @pending_count > 0
      render 'pending_users'
    end
  end

  def bulletins
    render partial: 'bulletins/bulletin', collection: @bulletins, cached: true
  end

  def create_bulletin
    render 'create_bulletin' if policy(Bulletin).create?
  end

  def under_construction
    render 'under_construction'
  end

end
