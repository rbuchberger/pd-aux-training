# This is a collection of classes for selecting which timecards to present,
# and for calculating things like duration. 

module TimecardsPresenter
  
  class FilteredTimecards
    # Initialize 0
    def initialize(start, finish, user, alltimecards)
      @timecards # = find everything in alltimecards that starts between start and finish.
      # If start and finish aren't specified, return all timecards. 
    end
    
    def total_time
      time = 0
      @timecards.each { |t| time += t.duration } 
    end
    
  end


  
end
