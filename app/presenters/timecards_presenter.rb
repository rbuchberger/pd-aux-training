module TimecardsPresenter
  
  class FilteredTimecards
    # Middleman, stands between model and controller.
    # Works out a list of timecards to return based on the inputs.
    # Implements default values if something isn't specified. 
    
    include ActiveModel::Model
    attr_accessor :range_start, :range_end, :user
    attr_reader :list
    
    def initialize
      default_start = Time.zone.today.beginning_of_day - 30.days
      default_end   = Time.zone.today.beginning_of_day
      @range_start  = @range_start.try(:beginning_of_day) || default_start 
      @range_end    = @range_end.end_of_day.try(:beginning_of_day) || default_end
      @user         = User.find[:user_id] || "all"
      
      if @user ==  "all" 
        @list = Timecard.where(start: s .. f).order(start: :desc)
      else 
        @list = @user.timecards.where(start: s .. f ).order(start: :desc)
      end
    end
    
    def total_duration
      time = 0
      @list.each { |t| time += t.duration_hours } 
      time
    end

  end
  
  class SelectOptions
    # Building a list of options for the select box.
    def new
      @select_options = {"All Users": 'all'}
      @users = User.all.order(:last_name)
      @users.each do |u|
        @select_options[u.last_first(20)] = u.id 
      end
    end
  end
  
end
