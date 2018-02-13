class Timecard < ApplicationRecord
  include ActiveModel::Validations

  # There's no easy rails way to split up dates & times in form fields, so the web forms are wired to
  # virtual attributes, and those values get parsed and combined for the actual database entries in a
  # before_validation callback. Clock out date is calculated based on the clock in date and common sense. 
  # Read values for these fields (so the form default values reflect database values) have custom methods.
  attribute :field_clock_in_date, :string, default: Time.zone.now.strftime("%Y-%m-%d") 
  attribute :field_clock_in_time, :datetime   
  attribute :field_clock_out_time, :datetime 
  
  # Relationships:
  belongs_to :user
  
  # Validations
  validates :description, presence: true, length: {maximum: 1000}
  validates :clock_in, presence: true 
  validates :clock_out, presence: true
  validates :user, presence: true
  validates_with TimecardValidator #Defined in concerns/timecard_validator.rb

  # Callbacks

  # This method turns the form field inputs into usable datetimes for the database. 
  def combine_fields
    puts 'Inputs to the combine_fields method, clock in date, clock in time, clock out time'
    self.clock_in = Time.zone.parse(
      "#{self.field_clock_in_date} #{self.field_clock_in_time.hour}:#{self.field_clock_in_time.min}"
    ) 
   
    # Note that clock_out date is initially assumed to be the same as clock_in date.
    self.clock_out = Time.zone.parse(
      "#{self.field_clock_in_date} #{self.field_clock_out_time.hour}:#{self.field_clock_out_time.min}"
    ) 
   
    # Timecards will never be more than 24 hours long. If clock_out is earlier than clock_in 
    # we assume the user worked past midnight. 
    self.clock_out += 1.day if self.clock_in >= self.clock_out

  end

  # Custom attributes:

  # Custom setters:
  def field_clock_in_date=(value)
    new = Time.zone.parse(value)
    self.clock_in = self.clock_in.change(year: new.year, month: new.month, day: new.day)
  end

  def field_clock_in_time=(value)
    self.clock_in = self.clock_in.change(hour: value.hour, minute: value.minute)
  end

  def field_clock_out_time=(value)
    self.clock_out = self.clock_out.change(hour: value.hour, minute: value.minute)
  end

  # Custom getters: 
  def field_clock_in_time
    self.clock_in ? self.clock_in : super
  end

  def field_clock_in_date
     self.clock_in ? self.clock_in.strftime("%Y-%m-%d") : super
  end

  def field_clock_out_time
    self.clock_out ? self.clock_out : super
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

