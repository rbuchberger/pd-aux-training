module TimecardsPresenter
  
  class FilteredTimecards
    # Middleman, stands between the model and controller.
    # Works out which timecards to return based on varying inputs.
    # Implements default values if something isn't specified. 
    
    attr_reader :list, :title, :selected_user_id, :select_options, :range_start, :range_end, :user_id
     
    def initialize(params = {}, user = nil)
      default_start = Time.zone.today.beginning_of_day - 30.days
      default_end   = Time.zone.today.end_of_day

      # If a user is passed in, it's coming from the non-admin page. 
      @select_options = SelectOptions.new unless user 

      if params[:range_start].blank?
        @range_start = default_start 
      else
        @range_start = params[:range_start].to_date.beginning_of_day
      end
      
      if params[:range_end].blank?
        @range_end = default_end
      else
        @range_end = params[:range_end].to_date.end_of_day
      end
      
      # Class can accept a user directly, or a user ID from a form
      if user
        @user = user
      elsif !params[:user_id].blank? # Note the !  
        @user = User.unscoped.find(params[:user_id])
        # Select options builder won't include deactivated users by default:  
        @select_options.add(@user) if @user.deleted_at
      end
      
      range = (@range_start .. @range_end)
      
      if !@user # If no user specified, return all users. 
        @selected_user_id = ""
        @list = Timecard.includes(:user).where(clock_in: range)
        @title = "All Users"
      else 
        @selected_user_id = @user.id
        @list = @user.timecards.where(clock_in: range)
        @title = @user.first_last
      end

    end
    
    def total_duration
      time = 0
      @list.each { |t| time += t.duration_hours } 
      time.round(2)
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
