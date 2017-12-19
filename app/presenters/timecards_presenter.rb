# This is a collection of classes for selecting which timecards to present,
# and for calculating things like duration. 

module TimecardsPresenter
  
  class FilteredTimecards
    
    def initialize(alltimecards)
      @timecards = alltimecards # = find everything in alltimecards that starts between start and finish.
      # If start and finish aren't specified, return all timecards. 
    end
    
    def total_duration
      time = 0
      @timecards.each { |t| time += t.duration } 
      time.round(1)
    end
    
    def list
      @timecards  
    end
    
  end


  
end
