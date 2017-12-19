# This is a collection of classes for selecting which timecards to present,
# and for calculating things like duration. 

# I'm not entirely sure separating this out is necessary. May incorporate this functionality
# back into the controller, we'll see how big it gets. 
module TimecardsPresenter
  
  class FilteredTimecards
    # Builder can accept a user, a start, and an end, but does not require any of them. If no arguments, will return 
    # all timecards for the past month (but only to users with proper permissions)
    def initialize(user = nil, start = 1.month.ago, finish = Time.zone.today)
      puts "arguments accepted"
      @user = user
      puts "user assigned"
      if @user 
        puts "user exists"
        @timecards = @user.timecards.all  #where("start >= :start AND start <= :finish", {start: start, finish: finish})
        puts "timecard assigned"
      elsif current_user.admin? || current_user.trainer?
        puts "user does not exist"
        @timecards = Timecard.where("start >= :start AND start <= :finish", {start: start, finish: finish})
        puts "timecards assigned"
      end
    
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
