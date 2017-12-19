# This is a collection of classes for selecting which timecards to present,
# and for calculating things like duration. 

# I'm not entirely sure separating this out is necessary. May incorporate this functionality
# back into the controller, we'll see how big it gets. 
module TimecardsPresenter
  
  class FilteredTimecards
    # Can accept a user, a start, and an end, but does not require any of them. 
    # By default, will return the current user's timecards for the past 30 days. 
    # A user_id of -1 will return all users. 
    
    def initialize(o = {})
      o.reverse_merge(start: 30.days.ago, end: Time.zone.today) 
      if o[:user_id] ==  -1 # Returns all users when user id is set to -1
        @timecards = Timecard.where("start >= :start AND start <= :finish", {start: start, finish: finish})
      else 
        @user = User.find(o[:user_id]) if o[:user_id] > 0
        @user ||= current_user
        @timecards = @user.timecards.all  #where("start >= :start AND start <= :finish", {start: start, finish: finish})
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
