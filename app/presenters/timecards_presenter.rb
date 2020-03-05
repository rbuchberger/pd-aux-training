module TimecardsPresenter
  class FilteredTimecards
    # This is a stand-in object which acts as a collection of timecards in
    # various circumstances. It is used by both the normal timecard index (where
    # a user can view their own timecards), and the admindex where admins &
    # trainers can view any single user's records, or all records together. It
    # handles setting default values, and parsing strings into datetimes.

    attr_reader :list, :select_options, :range_start, :range_end, :user

    def initialize(params: { user_id: '', range_start: '', range_end: '' }, user: nil, admindex: false)
      unless user || admindex
        raise ArgumentError, 'Must either specify a user or set admindex true'
      end

      # List of users for the admindex select dropdown:
      @select_options = SelectOptions.new if admindex

      # Build the date range:
      set_range(params[:range_start], params[:range_end])

      if admindex && params[:user_id].blank?
        # Return all users:
        @user = AllUsers.new # Stand-in class, defined below.
        @list = Timecard.includes(:user).where(clock_in: range)
      elsif admindex
        # Return user in params
        @user = User.unscoped.find(params[:user_id])
        @list = @user.timecards.where(clock_in: range)
        # If viewing a deactivated user, manually add them to select list:
        @select_options.add(@user) if @user.deleted_at
      else
        # Regular index action:
        @list = user.timecards.where(clock_in: range)
      end
    end

    def total_duration
      time = 0
      @list.each { |t| time += t.duration_hours }
      time.round(2)
    end

    # The forms want dates formatted a certain way:
    def formatted_range_start
      @range_start.strftime('%Y-%m-%d')
    end

    def formatted_range_end
      @range_end.strftime('%Y-%m-%d')
    end

    private

    def range
      (@range_start..@range_end)
    end

    def set_range(start, finish)
      # Params will give an empty string if nothing is entered, which is truthy.
      # We have to use .blank? to test for user input.
      @range_start = if start.blank?
                       Time.zone.today.beginning_of_day - 30.days
                     else
                       start.to_date.beginning_of_day
                     end

      @range_end = if finish.blank?
                     Time.zone.today.end_of_day
                   else
                     finish.to_date.end_of_day
                   end
    end
  end

  class SelectOptions
    # This class is used to list users for the admindex selection form.
    attr_reader :list

    def initialize
      @list = { 'All Users' => '' }
      User.all.each do |u|
        add(u)
      end
    end

    def add(user)
      @list[user.last_first(20)] = user.id
    end
  end

  class AllUsers
    # This is a stand in 'user' for the admindex form
    attr_reader :first_last, :id

    def initialize
      @first_last = 'All Users'
      @id = ''
    end
  end
end
