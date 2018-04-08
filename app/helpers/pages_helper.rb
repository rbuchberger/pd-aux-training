module PagesHelper

  def dynamic_homepage_content
    if user_signed_in?
      render 'pages/home/logged_in'
    else
      render 'pages/home/logged_out'
    end
  end

  def last_workday
    if @last_workday.blank?
      message = 'You have not logged any timecards.'
    else
      message = "
      Your most recent timecard was #{@last_workday.duration_hours} hours, on
      #{@last_workday.clock_in.strftime("%A, %b %d")}
      "
    end

    render partial: 'pages/home/last_workday', locals: {message: message}
  end

  def pending_users
    if policy(User).index? && @pending_count > 0
      render 'pages/home/pending_users'
    end
  end

  def bulletins
    render partial: 'bulletins/bulletin', collection: @bulletins, cached: true
  end

  def create_bulletin
    render 'pages/home/create_bulletin' if policy(Bulletin).create?
  end

  def under_construction
    render 'pages/home/under_construction'
  end

  def weekly_timecard_stats
    last_week = (Time.zone.now - 7.days .. Time.zone.now )
    query = Timecard.select(:clock_in, :clock_out, :user_id).where(clock_in: last_week)
    user_count = query.group(:user_id, :clock_in).count.count
    total_time = 0
    query.each { |t| total_time += t.duration_hours }

    render partial: 'pages/home/timecard_stats', locals: {user_count: user_count, total_time: total_time}
  end
end
