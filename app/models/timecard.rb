class Timecard < ApplicationRecord
  include ActiveModel::Validations

  # There's no easy rails way to split up dates & times in form fields that I can find, 
  # so the web forms are wired to virtual attributes, and those values get combined for
  # the actual database entries in a before_validation callback. Clock out date is 
  # calculated based on the clock in date and common sense. 

  # Virtual attributes: 
  attribute :clock_in_date, :date
  attribute :clock_in_time, :time
  attribute :clock_out_time, :time
  
  # Relationships:
  belongs_to :user
  
  # Validations:
  validates :description, presence: true, length: {maximum: 1000}
  validates :clock_in, presence: true 
  validates :clock_out, presence: true
  validates :user, presence: true
  validates_with TimecardValidator #Defined in concerns/timecard_validator.rb

  # Callbacks:
  after_initialize :set_field_values
  before_validation :set_db_values 

  # Scopes:
  default_scope { order clock_in: :desc }

  # Callback Definitions: 
  
  def set_field_values # Sets up virtual attributes for use by the web form

    self.clock_in_date  ||= self.clock_in?  ? self.clock_in.to_date : Time.zone.now.to_date 
    self.clock_in_time  ||= self.clock_in?  ? self.clock_in         : Time.zone.now
    self.clock_out_time ||= self.clock_out? ? self.clock_out        : Time.zone.now

  end

  def set_db_values # Assembles virtual attributes for the database values
    
    in_date  = self.clock_in_date
    in_time  = self.clock_in_time
    out_date = in_date
    out_time = self.clock_out_time

    # If clock out happens before clock in, we assume the user worked past midnight: 
    out_date += 1.day if in_time > out_time

    # These should handle time zones correcly, independent of server time, and including DST. 
    # The one exception is if someone clocks out on the day of a time change, but before 
    # it happens (at 3AM or so.) 

    self.clock_in  = Time.new(in_date.year, 
                              in_date.month, 
                              in_date.day, 
                              in_time.hour, 
                              in_time.min, 
                              0,
                              Time.zone.at(in_date.noon).utc_offset
                             )
    
    self.clock_out = Time.new(out_date.year, 
                              out_date.month, 
                              out_date.day, 
                              out_time.hour, 
                              out_time.min,
                              0,
                              Time.zone.at(out_date.noon).utc_offset
                             )

  end

  # Helper methods
  def duration # length of workday
    self.clock_out - self.clock_in  
  end
  
  def duration_hours(l=2) # Length of workday, in hours, rounded
   ( self.duration / 1.hour ).round(l)
  end
    
  def user # Allows viewing of deactivated users' timecards
    User.unscoped{ super }
  end

end

