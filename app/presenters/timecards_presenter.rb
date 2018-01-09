module TimecardsPresenter
  
  class FilteredTimecards
    # Middleman, stands between the model and controller.
    # Works out which timecards to return based on varying inputs.
    # Implements default values if something isn't specified. 
    
    # include ActiveModel::Model # (turns out I didn't need it.)
    
    attr_accessor :range_start, :range_end, :user_id
    attr_reader :list, :title, :selected_user_id, :select_options
     
    def initialize(opts = {}, user = nil)
      default_start = Time.zone.today.beginning_of_day - 30.days
      default_end   = Time.zone.today.end_of_day

      @select_options = SelectOptions.new 

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
        @user = User.unscoped.find(opts[:user_id])
        @select_options.add(@user) if @user.deleted_at # Select options builder won't include deactivated users, so we have to manually include them when selected specifically.  
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
    attr_accessor :list
    def initialize
      @list = {'All Users' => ''}
      User.all.each do |u|
        @list[u.last_first(20)] = u.id 
      end
    end

    def add(user)
      @list[user.last_first(20)] = user.id
    end
  end
  
end
