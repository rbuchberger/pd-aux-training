module TimecardsPresenter
  
  class FilteredTimecards
    # Middleman, stands between the model and controller.
    # Works out which timecards to return based on varying inputs.
    # Implements default values if something isn't specified. 
    
    # include ActiveModel::Model # (turns out I didn't need it.)
    
    attr_accessor :range_start, :range_end, :user_id
    attr_reader :list, :title, :selected_user_id
    
    def initialize(opts = {}, user = nil)
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
      
      if user
        @user = user
      elsif !opts[:user_id].blank? 
        @user = User.find(opts[:user_id])
      end
      
      range = (@range_start .. @range_end)
      
      if !@user # If no user specified, return all users. 
        @selected_user_id = ""
        @list = Timecard.where(start: range).order(start: :desc)
        @title = "All Users"
      else 
        @selected_user_id = @user.id
        @list = @user.timecards.where(start: range).order(start: :desc)
        @title = @user.first_last
      end

    end
    
    def total_duration
      time = 0
      @list.each { |t| time += t.duration_hours } 
      time
    end

  end
  
  class SelectOptions
    # Build a list of options for the user select box on the admindex.
    attr_reader :list
    def initialize
      @list = {'All Users' => ''}
      User.all.order(:last_name).each do |u|
        @list[u.last_first(20)] = u.id 
      end
    end
  end
  
end
