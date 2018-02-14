class Timecard < ApplicationRecord
  include ActiveModel::Validations

  # There's no easy rails way to split up dates & times in form fields, so the web forms are wired to
  # virtual attributes, and those values get combined for the actual database entries in a
  # before_validation callback. Clock out date is calculated based on the clock in date and common sense. 
  attribute :field_clock_in_date, :date
  attribute :field_clock_in_time, :time
  attribute :field_clock_out_time, :time
  
  # Relationships:
  belongs_to :user
  
  # Validations
  validates :description, presence: true, length: {maximum: 1000}
  validates :clock_in, presence: true 
  validates :clock_out, presence: true
  validates :user, presence: true
  validates_with TimecardValidator #Defined in concerns/timecard_validator.rb

  # Callbacks
  after_initialize :set_field_values
  before_validation :set_db_values 

  # Sets up virtual attributes for use by the form
  def set_field_values
    self.field_clock_in_date  ||= self.clock_in?  ? self.clock_in.to_date : Date.today 
    self.field_clock_in_time  ||= self.clock_in?  ? self.clock_in         : Time.zone.now
    self.field_clock_out_time ||= self.clock_out? ? self.clock_out        : Time.zone.now
  end

  # Assembles virtual attributes to useful values
  def set_db_values

    # For convenience: 

    in_date  = self.field_clock_in_date
    in_time  = self.field_clock_in_time
    out_time = self.field_clock_out_time

    # First we assume they happen on the same day. 
    self.clock_in  = Time.new(in_date.year, in_date.month, in_date.day, in_time.hour, in_time.min)
    self.clock_out = Time.new(in_date.year, in_date.month, in_date.day, out_time.hour, out_time.min)
    
    # If clock out happens before clock in, we assume the user worked past midnight. 
    self.clock_out += 1.day if self.clock_out < self.clock_in

  end

  # Length of workday 
  def duration
    self.clock_out - self.clock_in  
  end
  
  # Length of workday, in hours rounded to the nearest decimal place.
  def duration_hours(l=2)
   ( self.duration / 1.hour ).round(l)
  end
    
  # Allows viewing of deactivated users' timecards.
  def user
    User.unscoped{ super }
  end

end

