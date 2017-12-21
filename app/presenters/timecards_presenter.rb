module TimecardsPresenter
  
  class FilteredTimecards
    # Middleman, stands between model and controller.
    # Works out a list of timecards to return based on the inputs.
    # Implements default values if something isn't specified. 
    
    include ActiveModel::Model
    attr_accessor :range_start, :range_end, :user_id
    attr_reader :list
    
    def initialize(opts = {}, user = "all")
      default_start = Time.zone.today.beginning_of_day - 30.days
      default_end   = Time.zone.today.end_of_day
      
      if opts[:range_start].blank?
        @range_start = default_start 
      else
        @range_start = opts[:range_start].to_date.beginning_of_day
      end
      
      if opts[:range_end].blank?
        @range_end = default_end
      else
        @range_end = opts[:range_end].to_date.end_of_day
      end
      
      if opts[:user_id].blank?
        @user = user
      else
        @user = User.find(opts[:user_id])
      end
      
      range = (@range_start .. @range_end)
      
      if @user ==  "all" 
        @list = Timecard.where(start: range ).order(start: :desc)
      else 
        @list = @user.timecards.where(start: range ).order(start: :desc)
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
    attr_reader :list
    def initialize
      @list = {"All Users": 'all'}
      @users = User.all.order(:last_name)
      @users.each do |u|
        @list[u.last_first(20)] = u.id 
      end
    end
  end
  
end
