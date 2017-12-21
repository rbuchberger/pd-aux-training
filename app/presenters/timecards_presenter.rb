# This is a collection of classes for selecting which timecards to present,
# and for calculating things like duration. 

# I'm not entirely sure separating this out is necessary. May incorporate this functionality
# back into the controller, we'll see how big it gets. 
module TimecardsPresenter
  
  class FilteredTimecards
    # Middleman, stands between model and controller.
    # Requires a user, accepts a hash of 2 dates (start and finish). 
    # If user is a string "all", it will return all users. 

    def initialize(date_range, user)
      s = date_range[:start].beginning_of_day
      f = date_range[:finish].end_of_day
      @user = user
      if @user ==  "all" 
        @timecards = Timecard.where(start: s .. f).order(start: :desc)
      else 
        @timecards = @user.timecards.where(start: s .. f ).order(start: :desc)
      end
    end
    
    def total_duration
      time = 0
      @timecards.each { |t| time += t.duration_hours(1) } 
      time
    end
    
    def list
      @timecards 
    end
  end
end
